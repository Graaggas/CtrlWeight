import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:ctrl_weight/screens/charts/components/chart_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({Key key}) : super(key: key);

  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  bool _pressedButtonSevenDays = false;
  bool _pressedButtonMonthDays = false;
  bool _pressedButtonAllDays = false;

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    WeightsController weightsController = Get.find();
    _pressedButtonAllDays = weightsController.averAlldays.value;
    print("charts_page, _pressedButtonAllDays = $_pressedButtonAllDays");

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
                                primary: !_pressedButtonSevenDays
                                    ? colorButtons
                                    : Colors.red),
                            onPressed: () {
                              setState(() {
                                if (!_pressedButtonSevenDays) {
                                  _pressedButtonSevenDays =
                                      !_pressedButtonSevenDays;
                                  weightsController.changeAverSevenDays(
                                      _pressedButtonSevenDays);
                                }

                                if (_pressedButtonMonthDays) {
                                  _pressedButtonMonthDays =
                                      !_pressedButtonMonthDays;
                                  weightsController
                                      .changeAverMonth(_pressedButtonMonthDays);
                                }
                                if (_pressedButtonAllDays) {
                                  _pressedButtonAllDays =
                                      !_pressedButtonAllDays;
                                  weightsController
                                      .changeAverAllDays(_pressedButtonAllDays);
                                }
                                print(
                                    "in setState: 7days = $_pressedButtonSevenDays");
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
                                primary: !_pressedButtonMonthDays
                                    ? colorButtons
                                    : Colors.red),
                            onPressed: () {
                              setState(() {
                                if (!_pressedButtonMonthDays) {
                                  _pressedButtonMonthDays =
                                      !_pressedButtonMonthDays;
                                  weightsController
                                      .changeAverMonth(_pressedButtonMonthDays);
                                }

                                if (_pressedButtonSevenDays) {
                                  _pressedButtonSevenDays =
                                      !_pressedButtonSevenDays;
                                  weightsController.changeAverSevenDays(
                                      _pressedButtonSevenDays);
                                }
                                if (_pressedButtonAllDays) {
                                  _pressedButtonAllDays =
                                      !_pressedButtonAllDays;
                                  weightsController
                                      .changeAverAllDays(_pressedButtonAllDays);
                                }
                                print(
                                    "in setState: month = $_pressedButtonMonthDays");
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
                                primary: !_pressedButtonAllDays
                                    ? colorButtons
                                    : Colors.red),
                            onPressed: () {
                              setState(() {
                                if (!_pressedButtonAllDays) {
                                  _pressedButtonAllDays =
                                      !_pressedButtonAllDays;
                                  weightsController
                                      .changeAverAllDays(_pressedButtonAllDays);
                                }

                                if (_pressedButtonSevenDays) {
                                  _pressedButtonSevenDays =
                                      !_pressedButtonSevenDays;
                                  weightsController.changeAverSevenDays(
                                      _pressedButtonSevenDays);
                                }
                                if (_pressedButtonMonthDays) {
                                  _pressedButtonMonthDays =
                                      !_pressedButtonMonthDays;
                                  weightsController
                                      .changeAverMonth(_pressedButtonMonthDays);
                                }
                                print(
                                    "in setState: alldays = $_pressedButtonAllDays");
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
