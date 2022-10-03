import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/util/str_format.dart';
import '../compare_view_model.dart';
import '../util/chart_color.dart';

class _LineChart extends HookConsumerWidget {
  _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(compareViewModelProvider);
    LineChartBarData getLineChartBarData(int i) {
      List<FlSpot> spots = [];
      double index = 1;
      if (i == 0) {
        for (Map<String, Object?> item in state.dbResult1) {
          spots.add(
              FlSpot(index, double.parse(item[state.sqlTitleName].toString())));
          index += 1;
        }
      } else if (i == 1) {
        for (Map<String, Object?> item in state.dbResult2) {
          spots.add(
              FlSpot(index, double.parse(item[state.sqlTitleName].toString())));
          index += 1;
        }
      } else if (i == 2) {
        for (Map<String, Object?> item in state.dbResult3) {
          spots.add(
              FlSpot(index, double.parse(item[state.sqlTitleName].toString())));
          index += 1;
        }
      }
      return LineChartBarData(
        isCurved: false,
        color: chartColor[i],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: spots,
      );
    }

    List<LineChartBarData> lineBarsData2() {
      List<LineChartBarData> d = [];
      print("save index ===${state.saveIndex}");
      for (var i = 0; i < state.saveIndex; i++) {
        d.add(getLineChartBarData(i));
      }
      return d;
    }

    Widget bottomTitleWidgets(double value, TitleMeta meta) {
      if (value.toInt() % 2 != 1) {
        return const Text("");
      } else {
        if (value.toInt() + 1 > state.dbResult1.length) {
          return const Text("");
        } else {
          return RotatedBox(
              quarterTurns: 1,
              child: Text(
                "${state.dbResult1[value.toInt()]["year"].toString()}Q${state.dbResult1[value.toInt()]["month"].toString()}",
                style: TextStyle(fontSize: 10),
              ));
        }
      }
    }

    LineChartData sampleData2 = LineChartData(
      lineTouchData: lineTouchData2,
      gridData: gridData,
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            // getTitlesWidget: (value, meta) {
            //   Widget axisTitle = Text(
            //     value > 1000 || value < -1000
            //         ? (value / 1000).toInt().toString() + "K"
            //         : value.toString(),
            //     style:
            //         TextStyle(fontSize: value.toString().length > 4 ? 12 : 14),
            //   );

            //   // A workaround to hide the max value title as FLChart is overlapping it on top of previous
            //   if (value == meta.max || value == meta.min) {
            //     final remainder = value % meta.appliedInterval;
            //     if (remainder != 0.0 && remainder / meta.appliedInterval < 1) {
            //       axisTitle = const SizedBox.shrink();
            //     }
            //   }
            //   return SideTitleWidget(axisSide: meta.axisSide, child: axisTitle);
            // },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 70,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: borderData,
      // lineBarsData: bleChartStatus.data.isEmpty ? null : lineBarsData2(),
      lineBarsData: lineBarsData2(),
      minX: .0,
      maxX: 36.0,
      maxY: state.maxY,
      minY: state.minY,
    );
// milliseconds
    return LineChart(
      sampleData2,
      swapAnimationDuration: const Duration(milliseconds: 25),
    );
  }

  LineTouchData get lineTouchData2 => LineTouchData(
      enabled: true,
      touchTooltipData:
          LineTouchTooltipData(getTooltipItems: (List<LineBarSpot> spots) {
        return spots.asMap().entries.map((e) {
          int index = e.key;
          // if (index != 0) {
          //   return null;
          // }
          LineBarSpot spot = e.value;
          return LineTooltipItem(
            getFormatStepCount2(spot.y),
            // spot.y.toString(),
            TextStyle(
              color: spot.bar.gradient?.colors.first ??
                  spot.bar.color ??
                  Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          );
        }).toList();
      }),
      getTouchedSpotIndicator:
          (LineChartBarData barData, List<int> spotIndexes) {
        return spotIndexes.map((spotIndex) {
          final spot = barData.spots[spotIndex];
          if (spot.x == 0 || spot.x == 6) {
            return null;
          }
          return TouchedSpotIndicatorData(
            FlLine(color: Colors.white38, strokeWidth: 1),
            FlDotData(
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                    radius: 3,
                    color: Colors.transparent,
                    strokeWidth: 2,
                    strokeColor: Colors.white60);
              },
            ),
          );
        }).toList();
      });

  FlGridData get gridData => FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  // LineChartBarData get lineChartBarData1_1 => LineChartBarData(
  //       isCurved: true,
  //       color: const Color(0xff4af699),
  //       barWidth: 2,
  //       isStrokeCapRound: true,
  //       dotData: FlDotData(show: false),
  //       belowBarData: BarAreaData(show: false),
  //       spots: const [
  //         FlSpot(1, 1),
  //         FlSpot(3, 1.5),
  //         FlSpot(5, 1.4),
  //         FlSpot(7, 3.4),
  //         FlSpot(10, 2),
  //         FlSpot(12, 2.2),
  //         FlSpot(13, 1.8),
  //       ],
  //     );

  // LineChartBarData get lineChartBarData1_2 => LineChartBarData(
  //       isCurved: true,
  //       color: const Color(0xffaa4cfc),
  //       barWidth: 2,
  //       isStrokeCapRound: true,
  //       dotData: FlDotData(show: false),
  //       belowBarData: BarAreaData(
  //         show: false,
  //         color: const Color(0x00aa4cfc),
  //       ),
  //       spots: const [
  //         FlSpot(1, 1),
  //         FlSpot(3, 2.8),
  //         FlSpot(7, 1.2),
  //         FlSpot(10, 2.8),
  //         FlSpot(12, 2.6),
  //         FlSpot(13, 3.9),
  //       ],
  //     );

  // LineChartBarData get lineChartBarData1_3 => LineChartBarData(
  //       isCurved: true,
  //       color: const Color(0xff27b6fc),
  //       barWidth: 2,
  //       isStrokeCapRound: true,
  //       dotData: FlDotData(show: false),
  //       belowBarData: BarAreaData(show: false),
  //       spots: const [
  //         FlSpot(1, 2.8),
  //         FlSpot(3, 1.9),
  //         FlSpot(6, 3),
  //         FlSpot(10, 1.3),
  //         FlSpot(13, 2.5),
  //       ],
  //     );
}

class LineChartS extends StatefulWidget {
  const LineChartS({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartSState();
}

class LineChartSState extends State<LineChartS> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20, right: 15),
                child: _LineChart(isShowingMainData: false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
