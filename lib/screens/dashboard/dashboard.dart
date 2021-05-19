import 'package:ctrl_weight/controllers/waisteController.dart';
import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:ctrl_weight/misc/drawer.dart';
import 'package:ctrl_weight/screens/dashboard/components/panel.dart';
import 'package:ctrl_weight/screens/dashboard/components/widgets_average.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    WeightsController weightsController = Get.find();
    WaisteController waisteController = Get.find();

    return SafeArea(
      child: Scaffold(
        endDrawerEnableOpenDragGesture: false,
        drawer: CustomDrawer(context2: context),
        backgroundColor: colorBackgroindGradientStart,
        appBar: MyCustomAppBar(
          typeOfAppBar: TypeOfAppBar.all,
          height: sizeScreen.height * 0.2,
          header: "ПАНЕЛЬ ДАННЫХ",
          leftAppbarButton: LeftAppbarButton.menu,
          rightAppbarButton: RightAppbarButton.plus,
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
                  Obx(
                    () => Panel(
                      size: sizeScreen,
                      currentText: "ТЕКУЩИЙ ВЕС",
                      // currentValue: 138.2,
                      currentDiff: weightsController.diffWeight.value,
                      measure: " кг",
                      valueOfFill: weightsController.startWeight.value <
                              weightsController.currentWeight.value
                          ? 10000
                          : (weightsController.startWeight.value -
                                  weightsController.wantedWeight.value) /
                              (weightsController.startWeight.value -
                                  weightsController.currentWeight.value),
                      startValue: weightsController.startWeight.value,
                      wantedValue: weightsController.wantedWeight.value,
                      currentValue: weightsController.currentWeight.value,
                      colorStart: colorWeightProgressLineEnd,
                      colorEnd: colorWeightProgressLineStart,
                      typeOfProvider: "weight",
                    ),
                  ),
                  Obx(
                    () => Panel(
                      size: sizeScreen,
                      currentText: "ТЕКУЩИЙ ОБЪЕМ",
                      currentValue: waisteController.currentWaiste.value,
                      currentDiff: waisteController.diffWaiste.value,
                      measure: " см",
                      valueOfFill: waisteController.startWaiste.value <
                              waisteController.currentWaiste.value
                          ? 10000
                          : (waisteController.startWaiste.value -
                                  waisteController.wantedWaiste.value) /
                              (waisteController.startWaiste.value -
                                  waisteController.currentWaiste.value),
                      startValue: waisteController.startWaiste.value,
                      wantedValue: waisteController.wantedWaiste.value,
                      colorStart: colorWaisteProgressLineStart,
                      colorEnd: colorWaistePRogressLineEnd,
                      typeOfProvider: "waiste",
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 32.0, top: 16, right: 32),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => WidgetAverage(
                            weightAverage:
                                weightsController.averageWeightSevenDays.value,
                            waisteAverage:
                                waisteController.averageWaisteSevenDays.value,
                            sizeScreen: sizeScreen,
                            typeOfAverage: "НЕДЕЛЯ",
                          ),
                        ),
                        Obx(
                          () => WidgetAverage(
                            weightAverage: weightsController
                                .averageWeightFourteenDays.value,
                            waisteAverage: waisteController
                                .averageWaisteFourteenDays.value,
                            sizeScreen: sizeScreen,
                            typeOfAverage: "14 ДНЕЙ",
                          ),
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
                        Obx(
                          () => WidgetAverage(
                            weightAverage:
                                weightsController.averageWeightMonth.value,
                            waisteAverage:
                                waisteController.averageWaistetMonth.value,
                            sizeScreen: sizeScreen,
                            typeOfAverage: "МЕСЯЦ",
                          ),
                        ),
                        Obx(
                          () => WidgetAverage(
                            weightAverage:
                                weightsController.averageWeightAllDays.value,
                            waisteAverage:
                                waisteController.averageWaisteAllDays.value,
                            sizeScreen: sizeScreen,
                            typeOfAverage: "ВСЕГО",
                          ),
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
