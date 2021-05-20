import 'package:ctrl_weight/controllers/waisteController.dart';
import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:ctrl_weight/screens/weights/components/weight-card.dart';
import 'package:ctrl_weight/waistes/components/waist-card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaistesPage extends StatelessWidget {
  const WaistesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    WaisteController waisteController = Get.find();

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackgroindGradientStart,
        appBar: MyCustomAppBar(
          typeOfAppBar: TypeOfAppBar.waiste,
          height: sizeScreen.height * 0.2,
          header: "ЗАМЕРЫ ТАЛИИ",
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
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: waisteController.waisteList.length,
                      itemBuilder: (context, index) {
                        return WaisteCard(
                            waiste: waisteController.waisteList[index],
                            index: index,
                            dateTime: waisteController.timeList[index],
                            prevWaiste: index == 0
                                ? -1
                                : waisteController.waisteList[index - 1]);
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
