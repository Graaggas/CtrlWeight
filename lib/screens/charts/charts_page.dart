import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/chart_data.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:ctrl_weight/screens/charts/components/chart_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    WeightsController weightsController = Get.find();

    print("+++++++++++++++");
    print(" -- weights list --");
    weightsController.weightsChartList.forEach((element) {
      print(element.dateTime + " // " + element.weight.toString());
    });
    print("+++++++++++++++");

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
                Text("ВЕС"),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    //TODO add animated container for pressing button
                    Text("1"),
                    Text("2"),
                    Text("3"),
                    Text("43"),
                  ],
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
