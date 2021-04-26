import 'dart:math';

import 'package:ctrl_weight/dashboard/components/panel.dart';
import 'package:ctrl_weight/dashboard/components/widgets_average.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:ctrl_weight/provider_models/waiste_provider.dart';
import 'package:ctrl_weight/provider_models/weight_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackgroindGradientStart,
        appBar: MyCustomAppBar(
          height: sizeScreen.height * 0.2,
          header: "ПАНЕЛЬ ДАННЫХ",
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorBackgroindGradientStart,
                colorBackgroindGradientMiddle,
                colorBackgroindGradientEnd,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              // stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Panel(
                    size: sizeScreen,
                    currentText: "ТЕКУЩИЙ ВЕС",
                    currentValue: 138.2,
                    currentDiff: -12.01,
                    measure: " кг",
                    valueOfFill: 2,
                    startValue: 130,
                    wantedValue: 90,
                    colorStart: colorWeightProgressLineEnd,
                    colorEnd: colorWeightProgressLineStart,
                    typeOfProvider: futureCurrentWeightProvider,
                  ),
                  Panel(
                    size: sizeScreen,
                    currentText: "ТЕКУЩИЙ ОБЪЕМ",
                    currentValue: 111.02,
                    currentDiff: 11.1,
                    measure: " см",
                    valueOfFill: 3,
                    startValue: 112,
                    wantedValue: 101,
                    colorStart: colorWaisteProgressLineStart,
                    colorEnd: colorWaistePRogressLineEnd,
                    typeOfProvider: futureCurrentWaisteProvider,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 32.0, top: 16, right: 32),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WidgetAverage(
                          sizeScreen: sizeScreen,
                          typeOfAverage: "НЕДЕЛЯ",
                        ),
                        WidgetAverage(
                          sizeScreen: sizeScreen,
                          typeOfAverage: "14 ДНЕЙ",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 32.0, top: 16, right: 32),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WidgetAverage(
                          sizeScreen: sizeScreen,
                          typeOfAverage: "МЕСЯЦ",
                        ),
                        WidgetAverage(
                          sizeScreen: sizeScreen,
                          typeOfAverage: "ВСЕГО",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
