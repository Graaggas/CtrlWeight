import 'dart:async';
import 'dart:math';
import 'package:ctrl_weight/misc/chart_data.dart';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWeightWidget extends StatefulWidget {
  final List<WeightChart> weightChart;

  const ChartWeightWidget({Key key, this.weightChart}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartWeightWidgetState();
}

class ChartWeightWidgetState extends State<ChartWeightWidget> {
  List<BarChartGroupData> weightsList = [];
  double maxValueInWeights = 0.0;

  @override
  void initState() {
    for (int i = 0; i < widget.weightChart.length; i++) {
      print("~~ weight = ${widget.weightChart[i].weight.toString()}");
      weightsList.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
                y: widget.weightChart[i].weight,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }

    for (int i = 0; i < weightsList.length; i++) {
      if (widget.weightChart[i].weight >= maxValueInWeights) {
        maxValueInWeights = widget.weightChart[i].weight;
      }
    }

    maxValueInWeights = maxValueInWeights + 30.0;
    print('MAXVALUEINWEIGHTS: $maxValueInWeights');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: maxValueInWeights,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                tooltipPadding: const EdgeInsets.all(0),
                tooltipMargin: 8,
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.y.round().toString(),
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                  return '00 ${value.toString()}';
                  // switch (value.toInt()) {
                  //   case 0:
                  //     return 'Mn';
                  //   case 1:
                  //     return 'Te';
                  //   case 2:
                  //     return 'Wd';
                  //   case 3:
                  //     return 'Tu';
                  //   case 4:
                  //     return 'Fr';
                  //   case 5:
                  //     return 'St';
                  //   case 6:
                  //     return 'Sn';
                  //   default:
                  //     return '';
                  // }
                },
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: weightsList,
            //  [
            // BarChartGroupData(
            //   x: 0,
            //   barRods: [
            //     BarChartRodData(
            //         y: 8,
            //         colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //   ],
            //   showingTooltipIndicators: [0],
            // ),
            // BarChartGroupData(
            //   x: 1,
            //   barRods: [
            //     BarChartRodData(
            //         y: 10,
            //         colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //   ],
            //   showingTooltipIndicators: [0],
            // ),
            // BarChartGroupData(
            //   x: 2,
            //   barRods: [
            //     BarChartRodData(
            //         y: 14,
            //         colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //   ],
            //   showingTooltipIndicators: [0],
            // ),
            // BarChartGroupData(
            //   x: 3,
            //   barRods: [
            //     BarChartRodData(
            //         y: 15,
            //         colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //   ],
            //   showingTooltipIndicators: [0],
            // ),
            // BarChartGroupData(
            //   x: 3,
            //   barRods: [
            //     BarChartRodData(
            //         y: 13,
            //         colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //   ],
            //   showingTooltipIndicators: [0],
            // ),
            // BarChartGroupData(
            //   x: 3,
            //   barRods: [
            //     BarChartRodData(
            //         y: 10,
            //         colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //   ],
            //   showingTooltipIndicators: [0],
            // ),
            // ],
          ),
        ),
      ),
    );
  }
}
