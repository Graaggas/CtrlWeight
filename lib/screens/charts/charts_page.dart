import 'package:ctrl_weight/controllers/waisteController.dart';
import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:ctrl_weight/screens/charts/components/weight_comp.dart';
import 'package:ctrl_weight/screens/charts/components/waiste_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({Key key}) : super(key: key);

  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  bool _pressedButtonSevenDaysWeight = false;
  bool _pressedButtonMonthDaysWeight = false;
  bool _pressedButtonAllDaysWeight = false;

  bool _pressedButtonSevenDaysWaiste = false;
  bool _pressedButtonMonthDaysWaiste = false;
  bool _pressedButtonAllDaysWaiste = false;

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    WeightsController weightsController = Get.find();
    WaisteController waisteController = Get.find();
    _pressedButtonAllDaysWeight = weightsController.averAlldays.value;
    _pressedButtonAllDaysWaiste = waisteController.averAlldays.value;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackgroindGradientStart,
        appBar: MyCustomAppBar(
          typeOfAppBar: TypeOfAppBar.weight,
          height: sizeScreen.height * 0.2,
          header: "ГРАФИКИ",
          leftAppbarButton: LeftAppbarButton.backArrow,
          rightAppbarButton: RightAppbarButton.empty,
        ),
        body: Container(
          alignment: Alignment.topCenter,
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "ВЕС",
                    style: GoogleFonts.play(
                      color: colorTextInWhitePanels,
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                primary: !_pressedButtonSevenDaysWeight
                                    ? colorButtons
                                    : Colors.red),
                            onPressed: () {
                              setState(() {
                                if (!_pressedButtonSevenDaysWeight) {
                                  _pressedButtonSevenDaysWeight =
                                      !_pressedButtonSevenDaysWeight;
                                  weightsController.changeAverSevenDays(
                                      _pressedButtonSevenDaysWeight);
                                }

                                if (_pressedButtonMonthDaysWeight) {
                                  _pressedButtonMonthDaysWeight =
                                      !_pressedButtonMonthDaysWeight;
                                  weightsController.changeAverMonth(
                                      _pressedButtonMonthDaysWeight);
                                }
                                if (_pressedButtonAllDaysWeight) {
                                  _pressedButtonAllDaysWeight =
                                      !_pressedButtonAllDaysWeight;
                                  weightsController.changeAverAllDays(
                                      _pressedButtonAllDaysWeight);
                                }
                                print(
                                    "in setState: 7days = $_pressedButtonSevenDaysWeight");
                              });
                            },
                            child: Text("Неделя"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                primary: !_pressedButtonMonthDaysWeight
                                    ? colorButtons
                                    : Colors.red),
                            onPressed: () {
                              setState(() {
                                if (!_pressedButtonMonthDaysWeight) {
                                  _pressedButtonMonthDaysWeight =
                                      !_pressedButtonMonthDaysWeight;
                                  weightsController.changeAverMonth(
                                      _pressedButtonMonthDaysWeight);
                                }

                                if (_pressedButtonSevenDaysWeight) {
                                  _pressedButtonSevenDaysWeight =
                                      !_pressedButtonSevenDaysWeight;
                                  weightsController.changeAverSevenDays(
                                      _pressedButtonSevenDaysWeight);
                                }
                                if (_pressedButtonAllDaysWeight) {
                                  _pressedButtonAllDaysWeight =
                                      !_pressedButtonAllDaysWeight;
                                  weightsController.changeAverAllDays(
                                      _pressedButtonAllDaysWeight);
                                }
                                print(
                                    "in setState: month = $_pressedButtonMonthDaysWeight");
                              });
                            },
                            child: Text("Месяц"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                primary: !_pressedButtonAllDaysWeight
                                    ? colorButtons
                                    : Colors.red),
                            onPressed: () {
                              setState(() {
                                if (!_pressedButtonAllDaysWeight) {
                                  _pressedButtonAllDaysWeight =
                                      !_pressedButtonAllDaysWeight;
                                  weightsController.changeAverAllDays(
                                      _pressedButtonAllDaysWeight);
                                }

                                if (_pressedButtonSevenDaysWeight) {
                                  _pressedButtonSevenDaysWeight =
                                      !_pressedButtonSevenDaysWeight;
                                  weightsController.changeAverSevenDays(
                                      _pressedButtonSevenDaysWeight);
                                }
                                if (_pressedButtonMonthDaysWeight) {
                                  _pressedButtonMonthDaysWeight =
                                      !_pressedButtonMonthDaysWeight;
                                  weightsController.changeAverMonth(
                                      _pressedButtonMonthDaysWeight);
                                }
                                print(
                                    "in setState: alldays = $_pressedButtonAllDaysWeight");
                              });
                            },
                            child: Text("Всего"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GetBuilder<WeightsController>(
                      init: WeightsController(),
                      builder: (value) => ChartWeightWidget(
                        weightChart: weightsController.weightsChartList,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "ОБЪЕМ ТАЛИИ",
                    style: GoogleFonts.play(
                      color: colorTextInWhitePanels,
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                primary: !_pressedButtonSevenDaysWaiste
                                    ? colorButtons
                                    : Colors.red),
                            onPressed: () {
                              setState(() {
                                if (!_pressedButtonSevenDaysWaiste) {
                                  _pressedButtonSevenDaysWaiste =
                                      !_pressedButtonSevenDaysWaiste;
                                  waisteController.changeAverSevenDays(
                                      _pressedButtonSevenDaysWaiste);
                                }

                                if (_pressedButtonMonthDaysWaiste) {
                                  _pressedButtonMonthDaysWaiste =
                                      !_pressedButtonMonthDaysWaiste;
                                  waisteController.changeAverMonth(
                                      _pressedButtonMonthDaysWaiste);
                                }
                                if (_pressedButtonAllDaysWaiste) {
                                  _pressedButtonAllDaysWaiste =
                                      !_pressedButtonAllDaysWaiste;
                                  waisteController.changeAverAllDays(
                                      _pressedButtonAllDaysWaiste);
                                }
                              });
                            },
                            child: Text("Неделя"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                primary: !_pressedButtonMonthDaysWaiste
                                    ? colorButtons
                                    : Colors.red),
                            onPressed: () {
                              setState(() {
                                if (!_pressedButtonMonthDaysWaiste) {
                                  _pressedButtonMonthDaysWaiste =
                                      !_pressedButtonMonthDaysWaiste;
                                  waisteController.changeAverMonth(
                                      _pressedButtonMonthDaysWaiste);
                                }

                                if (_pressedButtonSevenDaysWaiste) {
                                  _pressedButtonSevenDaysWaiste =
                                      !_pressedButtonSevenDaysWaiste;
                                  waisteController.changeAverSevenDays(
                                      _pressedButtonSevenDaysWaiste);
                                }
                                if (_pressedButtonAllDaysWaiste) {
                                  _pressedButtonAllDaysWaiste =
                                      !_pressedButtonAllDaysWaiste;
                                  waisteController.changeAverAllDays(
                                      _pressedButtonAllDaysWaiste);
                                }
                              });
                            },
                            child: Text("Месяц"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                primary: !_pressedButtonAllDaysWaiste
                                    ? colorButtons
                                    : Colors.red),
                            onPressed: () {
                              setState(() {
                                if (!_pressedButtonAllDaysWaiste) {
                                  _pressedButtonAllDaysWaiste =
                                      !_pressedButtonAllDaysWaiste;
                                  waisteController.changeAverAllDays(
                                      _pressedButtonAllDaysWaiste);
                                }

                                if (_pressedButtonSevenDaysWaiste) {
                                  _pressedButtonSevenDaysWaiste =
                                      !_pressedButtonSevenDaysWaiste;
                                  waisteController.changeAverSevenDays(
                                      _pressedButtonSevenDaysWaiste);
                                }
                                if (_pressedButtonMonthDaysWaiste) {
                                  _pressedButtonMonthDaysWaiste =
                                      !_pressedButtonMonthDaysWaiste;
                                  waisteController.changeAverMonth(
                                      _pressedButtonMonthDaysWaiste);
                                }
                                print(
                                    "in setState: alldays = $_pressedButtonAllDaysWeight");
                              });
                            },
                            child: Text("Всего"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GetBuilder<WaisteController>(
                      init: WaisteController(),
                      builder: (value) => ChartWaisteWidget(
                        chartValue: waisteController.waisteChartList,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
