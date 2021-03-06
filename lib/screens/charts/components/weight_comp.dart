import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/chart_data.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class ChartWeightWidget extends StatelessWidget {
  final List<WeightChart> weightChart;

  ChartWeightWidget({
    Key key,
    this.weightChart,
  }) : super(key: key);

  final List<BarChartGroupData> weightsList = [];
  double maxValueInWeights = 0.0;

  void buildMonthChart(List<WeightChart> weightChart) {
    try {
      var cuDay = weightChart.last.dateTime;
      var currentDay = Jiffy(cuDay);

      int index = 0;

      var now = Jiffy(DateTime.now());
      var firstOfMonth = now.subtract(days: 31);

      for (int i = 0; i < weightChart.length; i++) {
        var r = Jiffy(weightChart[i].dateTime);

        if (r.isBetween(firstOfMonth, currentDay.add(days: 1))) {
          weightsList.add(
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(y: weightChart[i].weight, colors: [
                  colorBackgroindGradientStart,
                  colorBackgroindGradientStart
                ])
              ],
              // showingTooltipIndicators: [0],
            ),
          );
          index++;
        }

        // print("==> 14 => ${averageWeightFourteenDays.value}");
      }
      for (int i = 0; i < weightChart.length; i++) {
        if (weightChart[i].weight >= maxValueInWeights) {
          maxValueInWeights = weightChart[i].weight;
        }
      }

      maxValueInWeights = maxValueInWeights + 5.0;
    } catch (e) {
      print(e);
    }
  }

  void buildSevenDaysChart(List<WeightChart> weightChart) {
    try {
      var now = Jiffy(DateTime.now());
      var firstOfSevenDay = now.subtract(days: 7);
      int index = 0;

      for (int i = 0; i < weightChart.length; i++) {
        var cuDay = weightChart.last.dateTime;
        var currentDay = Jiffy(cuDay);
        var r = Jiffy(weightChart[i].dateTime);

        if (r.isBetween(firstOfSevenDay, currentDay.add(days: 1))) {
          weightsList.add(
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(y: weightChart[i].weight, colors: [
                  colorBackgroindGradientStart,
                  colorBackgroindGradientStart
                ])
              ],
              // showingTooltipIndicators: [0],
            ),
          );
          index++;
        }
      }

      for (int i = 0; i < weightChart.length; i++) {
        if (weightChart[i].weight >= maxValueInWeights) {
          maxValueInWeights = weightChart[i].weight;
        }
      }

      maxValueInWeights = maxValueInWeights + 5.0;
    } catch (e) {
      print(e);
    }
  }

  void buildAllDaysChart(List<WeightChart> weightChart) {
    try {
      for (int i = 0; i < weightChart.length; i++) {
        print("--buildAllDaysChar: weight = ${weightChart[i].weight}");
        weightsList.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(y: weightChart[i].weight, colors: [
                colorBackgroindGradientStart,
                colorBackgroindGradientStart
              ]),
            ],
            // showingTooltipIndicators: [1],
          ),
        );
      }

      for (int i = 0; i < weightsList.length; i++) {
        if (weightChart[i].weight >= maxValueInWeights) {
          maxValueInWeights = weightChart[i].weight;
        }
      }

      maxValueInWeights = maxValueInWeights + 5.0;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    WeightsController weightsController = Get.find();
    if (weightsController.averAlldays.value == true) {
      buildAllDaysChart(weightChart);
    }
    if (weightsController.averSevenDays.value == true) {
      buildSevenDaysChart(weightChart);
    }
    if (weightsController.averMonth.value == true) {
      buildMonthChart(weightChart);
    }

    print("averalldays = ${weightsController.averAlldays.value}");
    print("aver7days = ${weightsController.averSevenDays.value}");
    print("averMonth = ${weightsController.averMonth.value}");

    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: colorAppBarGradientEnd,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarChart(
            BarChartData(
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                horizontalInterval: 10,
                checkToShowVerticalLine: (value) => true,
              ),
              alignment: BarChartAlignment.spaceAround,
              maxY: maxValueInWeights,
              barTouchData: BarTouchData(
                enabled: true,
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
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: false,
                  getTextStyles: (value) => const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  margin: 20,
                ),
                leftTitles: SideTitles(
                  interval: 10,
                  margin: 5,
                  showTitles: true,
                  getTextStyles: (value) => TextStyle(
                    color: colorTextInPanels,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              borderData: FlBorderData(
                border: Border(
                  top: BorderSide(
                    color: colorAppBarButtons,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  right: BorderSide(
                    color: colorAppBarButtons,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  bottom: BorderSide(
                    color: colorAppBarButtons,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  left: BorderSide(
                    color: colorAppBarButtons,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                show: true,
              ),
              barGroups: weightsList,
            ),
            swapAnimationDuration: Duration(milliseconds: 1), // Optional
            swapAnimationCurve: Curves.bounceIn, // Optional
          ),
        ),
      ),
    );
  }
}
