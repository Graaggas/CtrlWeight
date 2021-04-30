import 'package:ctrl_weight/controllers/firstMeetingFlagController.dart';
import 'package:ctrl_weight/controllers/waisteController.dart';
import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StartValuesScreen extends StatefulWidget {
  @override
  _StartValuesScreenState createState() => _StartValuesScreenState();
}

class _StartValuesScreenState extends State<StartValuesScreen> {
  final textWeightController = TextEditingController();
  final textHeightController = TextEditingController();

  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void dispose() {
    textHeightController.dispose();
    textWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    FirstMeetingFlagController flagController = Get.find();
    WeightsController weightsController = Get.find();
    WaisteController waisteController = Get.find();

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackgroindGradientStart,
        appBar: MyCustomAppBar(
          height: size.height * 0.2,
          header: "НАЧАЛЬНЫЕ ЗНАЧЕНИЯ",
        ),
        body: Container(
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 16,
                    bottom: 16,
                  ),
                  child: TextFormField(
                    controller: textWeightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите значение";
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r"^\d+\.?\d{0,2}"))
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                      ),
                      focusColor: Colors.blue,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: colorAppBarGradientStart,
                      filled: true,
                      hintText: 'Желаемый вес, кг',
                      // enabled: checkController.getWaisteChecking
                      //     ? true
                      //     : false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 16,
                    bottom: 16,
                  ),
                  child: TextFormField(
                    controller: textHeightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите значение";
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r"^\d+\.?\d{0,2}"))
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                      ),
                      focusColor: Colors.blue,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: colorAppBarGradientStart,
                      filled: true,
                      hintText: 'Рост, см',
                      // enabled: checkController.getWaisteChecking
                      //     ? true
                      //     : false,
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 300, height: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5, primary: colorButtons),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        flagController.changeFlagInHive();
                        weightsController.saveWantedWeight(
                            double.parse(textWeightController.text));
                        waisteController.calculateWantedWaiste(
                            double.parse(textHeightController.text));

                        Get.offAllNamed("/dashboard_screen");

                        //* save data via provider and go to dashboard
                        // final providerWeight = watch(weightNotifierProvider);
                        // final flagProvider = watch(getFlagProvider);
                        // providerWeight.saveWantedWeight(
                        //     double.parse(textWeightController.text));
                        // flagProvider.changeFlag();

                        // Navigator.pushReplacementNamed(
                        //     context, "/dashboard_screen");
                      } else {
                        //* do nothing
                      }
                    },
                    child: Text(
                      "Добавить",
                      style: GoogleFonts.play(
                        color: colorTextIcons,
                        fontSize: 18,
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
