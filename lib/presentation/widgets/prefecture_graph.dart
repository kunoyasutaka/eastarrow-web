// import 'package:charts_flutter/flutter.dart';
// import 'package:eastarrow_web/config/constants.dart';
// import 'package:eastarrow_web/domain/user.dart';
// import 'package:flutter/material.dart';
//
// /// 拠点グラフ
// class PrefectureGraph extends StatelessWidget {
//   const PrefectureGraph({Key? key, required this.members}) : super(key: key);
//
//   final List<User> members;
//
//   @override
//   Widget build(BuildContext context) {
//     // 円グラフ
//     return PieChart(
//       _createSeries(),
//       animate: kGraphAnimate,
//       animationDuration: kGraphAnimationDuration,
//       defaultRenderer: ArcRendererConfig(
//         // ドーナツ形状
//         arcWidth: 60,
//         arcRendererDecorators: [
//           // ラベルを表示する
//           ArcLabelDecorator(),
//         ],
//       ),
//     );
//   }
//
//   /// グラフで使うデータセットを返す
//   List<Series<PrefectureData, String>> _createSeries() {
//     return [
//       Series<PrefectureData, String>(
//         id: '拠点',
//         data: _createValues(),
//         domainFn: (value, _) => value.prefecture.nameJpn,
//         measureFn: (value, _) => value.count,
//         labelAccessorFn: (value, _) =>
//             '${value.prefecture.nameJpn} : ${value.count}',
//       ),
//     ];
//   }
//
//   /// グラフで使うデータを返す
//   List<PrefectureData> _createValues() {
//     List<PrefectureData> values = [];
//
//     // 未登録は除く
//     members
//         .where((m) => m.prefecture != Prefecture.UNSELECTED)
//         .forEach((member) {
//       if (values.where((d) => d.prefecture == member.prefecture).isEmpty) {
//         // なければデータクラスを初期化
//         values.add(PrefectureData(member.prefecture));
//       }
//
//       // 拠点毎にインクリメントする
//       values.where((d) => d.prefecture == member.prefecture).first.count++;
//     });
//
//     // 件数の降順で並び替え
//     values.sort((a, b) {
//       return b.count - a.count;
//     });
//
//     return values;
//   }
// }
//
// /// グラフで使うデータクラス
// class PrefectureData {
//   PrefectureData(this.prefecture);
//
//   final Prefecture prefecture;
//   int count = 0;
//
//   String get label => '${prefecture.nameJpn} : $count';
//
//   @override
//   String toString() {
//     return label;
//   }
// }
