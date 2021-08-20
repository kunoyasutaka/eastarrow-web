import 'dart:async';

import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/exception/application_exception.dart';
import 'package:flutter/material.dart';

import 'base_model.dart';

/// 一覧ページ用のViewModel
abstract class IndexModel<T> extends BaseModel {
  IndexModel(
    BuildContext context, {
    this.sortColumnName = 'id',
    this.sortAscending = false,
    this.rowsPerPage = 10,
    this.availableRowsPerPage = const [10, 20, 50, 100],
    this.primaryKey = 'id',
    this.recordDisplayName = 'レコード',
  }) : super(context) {
    // 検索文字列が更新された
    filterTextController.addListener(() {
      filterTexts = filterTextController.text.trim().split(' ');
      _willSearch = false;
      _latestTick = (_timer != null) ? _timer!.tick : 0;

      // ここでは notifyListeners() せず、Timer処理で行う
    });

    // インクリメンタルサーチのタイマー管理
    // 1秒毎に監視し、入力後1秒以上経過してたら検索を実行する
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_willSearch) {
        if (_latestTick != null && timer.tick > _latestTick!) {
          _willSearch = true;
        }
      }
      if (_willSearch) {
        _willSearch = false;
        _latestTick = null;
        if (filterTexts != null && filterTexts.isNotEmpty) {
          setSession(kSessionFilterText, filterTextController.text);
          notifyListeners();
        }
      }
    });
  }

  /// レコード
  List<T> records = [];
  final String recordDisplayName;

  /// 並び替え条件
  String? sortColumnName;
  bool sortAscending;

  /// 初期表示時の行Index
  late int initialFirstRowIndex;

  /// テキスト検索
  final filterTextController = TextEditingController();
  List<String> filterTexts = [];
  bool _willSearch = true;
  Timer? _timer;
  int? _latestTick;

  /// 1ページあたりの表示件数
  int rowsPerPage;
  List<int> availableRowsPerPage;

  /// 選択モードかどうか
  bool isSelecting = false;

  /// 選択中のkey一覧
  List<String> selectedRowKeys = [];
  final String primaryKey;

  /// abstract 一覧を取得する
  @protected
  Future<List<T>> fetchAll();

  /// abstract 削除する
  @protected
  Future delete(T record);

  /// abstract 検索する
  @protected
  T find(String key);

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    filterTextController.dispose();
    super.dispose();
  }

  @override
  Future init() async {
    if (getArgumentValue<bool>(kArgsClearSession, defaultValue: false)!) {
      // セッションクリアする
      await clearSession();
    }

    // クエリから取得するが、なければセッションから復元する
    sortColumnName = getQueryParameter(
      kQuerySortColumnName,
      defaultValue: await getSession<String>(
        kSessionSortColumnName,
        defaultValue: sortColumnName,
      ),
    );

    final asc = getQueryParameter(kQuerySortAscending);
    if (asc != null) {
      sortAscending = asc.isNotEmpty;
    } else {
      sortAscending = await getSession<bool>(
            kSessionSortAscending,
            defaultValue: sortAscending,
          ) ??
          false;
    }

    final page = getQueryParameter(kQueryRowsPerPage);
    if (page != null) {
      rowsPerPage = int.parse(page);
    } else {
      rowsPerPage = await getSession<int>(
            kSessionRowsPerPage,
            defaultValue: rowsPerPage,
          ) ??
          0;
    }

    final rowIndex = getQueryParameter(kQueryInitialFirstRowIndex);
    if (rowIndex != null) {
      initialFirstRowIndex = int.parse(rowIndex);
    } else {
      initialFirstRowIndex = await getSession<int>(
            kSessionInitialFirstRowIndex,
            defaultValue: initialFirstRowIndex,
          ) ??
          1;
    }

    filterTextController.text = getQueryParameter(
      kQueryFilterText,
      defaultValue: await getSession<String>(
        kSessionFilterText,
        defaultValue: filterTextController.text,
      ),
    );

    // 一覧を取得する
    startLoading();
    try {
      records = await fetchAll();
    } on ApplicationException catch (e) {
      errorMessages.clear();
      errorMessages.addAll(e.errorMessages);
    } finally {
      endLoading();
    }
  }

  /// 選択中のレコードを一括削除する
  Future deleteSelected() async {
    if (selectedRowKeys.isEmpty) {
      return;
    }

    if (!await showConfirmDialog(
        message: '${selectedRowKeys.length}件の$recordDisplayNameを削除しますか？')) {
      return;
    }

    startLoading();
    try {
      for (String key in selectedRowKeys) {
        final record = find(key);
        if (record != null) {
          await delete(record);
        }
      }

      // 一覧を取得し直す
      records = await fetchAll();

      messages.clear();
      messages.add('${selectedRowKeys.length}件の$recordDisplayNameを削除しました');

      // 選択状態を解除する
      selectedRowKeys.clear();
      isSelecting = false;
    } on ApplicationException catch (e) {
      errorMessages.clear();
      errorMessages.addAll(e.errorMessages);
    } finally {
      endLoading();
    }
  }

  /// 選択中のkey一覧を更新する
  void updateSelectedRowKeys(List<String> keys) {
    selectedRowKeys = keys;
    notifyListeners();
  }

  /// 並び替え条件を更新する
  void updateSortCondition(String columnName, bool ascending) {
    sortColumnName = columnName;
    sortAscending = ascending;

    // セッションに保存する
    setSession(kSessionSortColumnName, sortColumnName);
    setSession(kSessionSortAscending, sortAscending);
    notifyListeners();
  }

  /// ページ毎の表示件数を更新する
  void updateRowsPerPage(int? page) {
    if (page != null) {
      rowsPerPage = page;
    } else {
      rowsPerPage = 0;
    }

    // セッションに保存する
    setSession(kSessionRowsPerPage, rowsPerPage);
    notifyListeners();
  }

  /// 初期表示時の行Indexを更新する
  void updateInitialFirstRowIndex(int rowIndex) {
    this.initialFirstRowIndex = rowIndex;

    // セッションに保存する
    setSession(kSessionInitialFirstRowIndex, rowIndex);
    notifyListeners();
  }

  /// 選択モードを切り替える
  void toggleSelecting() {
    isSelecting = !isSelecting;
    selectedRowKeys = [];
    notifyListeners();
  }
}
