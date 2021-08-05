import 'dart:convert';
import 'dart:typed_data';

import 'package:eastarrow_web/config/constants.dart';
import 'package:eastarrow_web/repository/session_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';
import 'package:flutter_web_router/flutter_web_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// 共通のViewModel
/// ログイン後の各画面のViewModelはこのクラスを継承すること
class BaseModel extends ChangeNotifier {
  BaseModel(this.context)
      : request = _getRequest(context),
        messages = _getMessages(context),
        errorMessages = _getErrorMessages(context),
        sessionPrefix = _getSessionPrefix(context) {
    init();
  }

  /// messagesを返す
  static List<String> _getMessages(BuildContext context) {
    return _getArguments(context) is Map
        ? (_getArguments(context) as Map)[kArgsMessages] ?? []
        : [];
  }

  /// errorMessagesを返す
  static List<String> _getErrorMessages(BuildContext context) {
    return _getArguments(context) is Map
        ? (_getArguments(context) as Map)[kArgsErrorMessages] ?? []
        : [];
  }

  /// sessionPrefixを返す
  /// パスを逆順にしてドットでつなげた文字列
  static String _getSessionPrefix(BuildContext context) {
    final request = _getRequest(context);
    final paths = request.uri.pathSegments;
    final routes = request.route!.split('/');
    List<String> prefixs = [];
    for (final path in paths) {
      if (routes.contains(path)) {
        prefixs.add(path);
      }
    }
    if (prefixs.isEmpty) {
      prefixs.add('root');
    }
    return prefixs.reversed.join('.');
  }

  /// argumentsを返す
  static Object? _getArguments(BuildContext context) {
    return _getRequest(context).settings.arguments;
  }

  /// WebRequestを返す
  static WebRequest _getRequest(BuildContext context) {
    return Provider.of<WebRequest>(context, listen: false);
  }

  /// ViewModelがcontextを持つことで画面遷移とポップアップ表示のトリガーをViewModelが担うことが出来て、
  /// View側にロジックを一切書かなくすることが出来る。
  /// 本来は、ViewModelのViewへの依存性を低くし、ViewModelの単体テストを容易にできるようにすることが望ましい。
  /// そのためにはViewModelはcontextは持たない方がよいが、実装の難易度が上がってしまうので現状のままとしている。
  /// ViewModelのcontext非依存のアイデアとしては、streamやlistener等を使ってViewModelからViewにイベントを発行し、
  /// View側で画面遷移とポップアップ表示をすることが考えられる。
  final BuildContext context;

  /// リクエスト情報
  final WebRequest request;

  /// 通常メッセージ
  final List<String> messages;

  /// エラーメッセージ
  final List<String> errorMessages;

  final _sessionRepository = SessionRepository();

  /// セッションプレフィックス
  String sessionPrefix = '';

  /// ローディングフラグ
  bool isLoading = false;

  /// dispose済みかどうか
  bool _mounted = false;

  ///
  /// Method
  ///
  @override
  void dispose() {
    super.dispose();
    _mounted = true;
  }

  @override
  void notifyListeners() {
    if (!_mounted) {
      super.notifyListeners();
    }
  }

  @protected
  Future init() async {}

  @protected
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  @protected
  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  ///
  /// URL
  ///
  /// URLを開く
  Future openUrl(String urlString) async {
    if (await canLaunch(urlString)) {
      launch(urlString);
    }
  }

  ///
  /// ダイアログ
  ///
  /// アラートダイアログを表示する
  @protected
  Future showAlertDialog({
    String? title,
    String? message,
    Function()? onTapOk,
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BootstrapModal(
          title: title != null ? Text(title) : null,
          content: message != null ? Text(message) : null,
          actions: [
            BootstrapButton(
              child: const Text('OK'),
              onPressed: () {
                if (onTapOk != null) {
                  onTapOk();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// エラーダイアログを表示する
  @protected
  Future showErrorAlertDialog({
    Exception? e,
    Function()? onTapOk,
  }) async {
    await showAlertDialog(
      title: 'エラー',
      message: e.toString(),
      onTapOk: onTapOk,
    );
  }

  /// 確認ダイアログを表示する
  @protected
  Future<bool> showConfirmDialog({
    String? title,
    String? message,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return BootstrapModal(
              title: title != null ? Text(title) : null,
              content: message != null ? Text(message) : null,
              actions: [
                BootstrapButton(
                  child: Text('いいえ'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                BootstrapButton(
                  type: BootstrapButtonType.primary,
                  child: Text('はい'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// 日付選択ダイアログ（DatePicker）を表示する
  Future<DateTime?> showDatePickerDialog(DateTime dateTime) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
      initialDate: dateTime,
      builder: (BuildContext context, Widget? child) {
        if (child != null) {
          return child;
        } else {
          return SizedBox();
        }
      },
    );
  }

  /// 画像選択ダイアログ（ImagePicker）を表示する
  Future<Uint8List> showImagePickerDialog() async {
    final methodChannel = const MethodChannel('flutter_web_image_picker');
    final data =
        await methodChannel.invokeMapMethod<String, dynamic>('pickImage');
    return base64.decode(data!['data']);
  }

  /// AboutDialogを表示する
  void showAdminAboutDialog() async {
    final version = await rootBundle.loadString('web/version.txt');
    showAboutDialog(
      context: context,
      applicationIcon: SizedBox(
        width: 100,
        height: 100,
        child: Image.asset('web/icons/Icon-192.png'),
      ),
      applicationVersion: version,
      applicationLegalese: kCopyRight,
    );
  }

  ///
  /// Navigation
  ///
  /// ページ遷移する
  Future push(
    String route, {
    Map<String, String>? data,
    Map<String, String>? queryParameters,
    Object? arguments,
  }) async {
    final request = WebRequest.request(
      route,
      data: data,
      queryParameters: queryParameters,
      arguments: arguments,
    );

    await Navigator.of(context).pushNamed(
      request.uri.toString(),
      arguments: arguments,
    );
  }

  /// ページスタックをクリアしてページを開く
  Future reopen(
    String route, {
    Map<String, String>? data,
    Map<String, String>? queryParameters,
    Object? arguments,
  }) async {
    final request = WebRequest.request(
      route,
      data: data,
      queryParameters: queryParameters,
      arguments: arguments,
    );

    bool found = false;
    await Navigator.of(context).pushNamedAndRemoveUntil(
      request.uri.toString(),
      (requestRoute) {
        if (found) {
          return true;
        }

        final request =
            WebRequest.settings(requestRoute.settings, route: route);
        if (request.verify) {
          found = true;
          return false;
        }
        return false;
      },
      arguments: arguments,
    );
  }

  /// ページを開き直す
  Future replace(
    String route, {
    Map<String, String>? data,
    Map<String, String>? queryParameters,
    Object? arguments,
  }) async {
    final request = WebRequest.request(
      route,
      data: data,
      queryParameters: queryParameters,
      arguments: arguments,
    );
    await Navigator.of(context).pushReplacementNamed(
      request.uri.toString(),
      arguments: arguments,
    );
  }

  /// ページを1つ戻る
  Future pop() async {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  ///
  /// Session
  ///
  /// セッションに値を保存する
  Future<bool> setSession(String key, dynamic value) async {
    return await _sessionRepository.set(key, value, prefix: sessionPrefix);
  }

  /// セッションから値を取得する
  Future<T?> getSession<T>(String key, {T? defaultValue}) async {
    return await _sessionRepository.get(key,
        prefix: sessionPrefix, defaultValue: defaultValue);
  }

  /// セッションをクリアする
  Future<bool> clearSession() async {
    return await _sessionRepository.remove(sessionPrefix);
  }

  ///
  /// Query
  ///
  /// クエリから値を取得する
  String? getQueryParameter(String key, {String? defaultValue}) {
    final value = request.uri.queryParameters[key];
    return value != null ? value : defaultValue;
  }

  ///
  /// Args
  ///
  /// RouteSettingsのargumentsをMapとして返す
  Map<String, dynamic> get argumentsMap => (request.settings.arguments != null)
      ? request.settings.arguments as Map<String, dynamic>
      : {};

  /// RouteSettingsのargumentsから値を取得する
  T? getArgumentValue<T>(String key, {T? defaultValue}) {
    final value = argumentsMap[key] as T;
    return value != null ? value : defaultValue;
  }
}
