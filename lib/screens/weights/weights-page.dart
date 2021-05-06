import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:ctrl_weight/screens/weights/components/weight-card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeightsPage extends StatelessWidget {
  const WeightsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    WeightsController weightsController = Get.find();

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackgroindGradientStart,
        appBar: MyCustomAppBar(
          typeOfAppBar: TypeOfAppBar.weight,
          height: sizeScreen.height * 0.2,
          header: "ТАБЛИЦА ВЕСОВ",
          leftAppbarButton: LeftAppbarButton.backArrow,
          rightAppbarButton: RightAppbarButton.plus,
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
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Obx(
                  () => ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: weightsController.weightsList.length,
                      itemBuilder: (context, index) {
                        return WeightCard(
                            weight: weightsController.weightsList[index],
                            index: index,
                            dateTime: weightsController.timeList[index],
                            prevWeight: index == 0
                                ? -1
                                : weightsController.weightsList[index - 1]);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
