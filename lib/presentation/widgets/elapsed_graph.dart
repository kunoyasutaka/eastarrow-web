// import 'package:charts_flutter/flutter.dart';
// import 'package:eastarrow_web/config/constants.dart';
// import 'package:eastarrow_web/domain/user.dart';
// import 'package:flutter/material.dart';
//
// /// プラン毎の在籍月数グラフ
// class ElapsedGraph extends StatelessWidget {
//   static const kPlanNameOther = 'その他';
//   final List<User> members;
//
//   const ElapsedGraph({Key? key, required this.members}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // 棒グラフ
//     return BarChart(
//       _createSeries(),
//       animate: kGraphAnimate,
//       animationDuration: kGraphAnimationDuration,
//       defaultRenderer: BarRendererConfig(
//         // 積み上げ
//         groupingType: BarGroupingType.stacked,
//         // 棒グラフ内に人数を表示する
//         barRendererDecorator: BarLabelDecorator<String>(),
//       ),
//       behaviors: [
//         // 凡例を表示する
//         SeriesLegend(
//           position: BehaviorPosition.top,
//         ),
//       ],
//     );
//   }
//
//   /// グラフで使うデータセットを返す
//   List<Series<ElapsedData, String>> _createSeries() {
//     return [
//       Series<ElapsedData, String>(
//         id: kPlanNameOther,
//         data: _createValues(kPlanNameOther),
//         domainFn: (value, _) => value.label,
//         measureFn: (value, _) => value.count,
//         colorFn: (_, __) => MaterialPalette.gray.shadeDefault,
//         labelAccessorFn: (value, _) => value.count > 0 ? '${value.count}人' : '',
//       ),
//       Series<ElapsedData, String>(
//         id: kCarType,
//         data: _createValues(kCarType),
//         domainFn: (value, _) => value.label,
//         measureFn: (value, _) => value.count,
//         colorFn: (_, __) => MaterialPalette.cyan.shadeDefault,
//         labelAccessorFn: (value, _) => value.count > 0 ? '${value.count}人' : '',
//       ),
//       Series<ElapsedData, String>(
//         id: kCarType,
//         data: _createValues(kCarType),
//         domainFn: (value, _) => value.label,
//         measureFn: (value, _) => value.count,
//         colorFn: (_, __) => MaterialPalette.teal.shadeDefault,
//         labelAccessorFn: (value, _) => value.count > 0 ? '${value.count}人' : '',
//       ),
//     ];
//   }
//
//   /// プラン名毎のグラフで使うデータを返す
//   List<ElapsedData> _createValues(String planName) {
//     List<ElapsedData> values = [];
//
//     // 在籍月数の最大値
//     int maxElapsed =
//         members.map((m) => m.subscription.elapsed).toList().reduce(max);
//
//     // 0で初期化
//     for (int elapsed = 1; elapsed <= maxElapsed; elapsed++) {
//       values.add(ElapsedData(elapsed));
//     }
//
//     // プラン名で絞って、在籍月数毎にインクリメントする
//     members.where((m) => _matchPlanName(m, planName)).forEach((member) {
//       values
//           .where((d) => d.elapsed == member.subscription.elapsed)
//           .first
//           .count++;
//     });
//     return values;
//   }
//
//   /// プラン名が一致するかを返す
//   bool _matchPlanName(Member member, String planName) {
//     if (planName == kPlanNameOther) {
//       if (member.currentPlan == null) {
//         return false;
//       }
//       return ![kPlanNameTraining, kPlanNameCommunity]
//           .contains(member.currentPlan.name);
//     }
//     return member.currentPlan?.name == planName;
//   }
// }
//
// /// グラフで使うデータクラス
// class ElapsedData {
//   ElapsedData(this.elapsed);
//
//   final int elapsed;
//   int count = 0;
//
//   String get label {
//     final year = (elapsed / 12).floor();
//     final month = elapsed % 12;
//     return year > 0 ? '$year年\n$monthヶ月目' : '$monthヶ月目';
//   }
//
//   @override
//   String toString() {
//     return '$label: $count';
//   }
// }
