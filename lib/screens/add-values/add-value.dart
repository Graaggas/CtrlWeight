import 'package:ctrl_weight/controllers/waisteController.dart';
import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddValuePage extends StatefulWidget {
  final ChoosingTypeOfValue typeOfValue;

  const AddValuePage({this.typeOfValue});

  static Future<void> show(
      BuildContext context, ChoosingTypeOfValue typeOfValue) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddValuePage(
          typeOfValue: typeOfValue,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddValuePageState createState() => _AddValuePageState();
}

class _AddValuePageState extends State<AddValuePage> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    var typeOfValueString = "";

    switch (widget.typeOfValue) {
      case ChoosingTypeOfValue.weight:
        typeOfValueString = "НОВЫЙ ВЕС";
        break;
      case ChoosingTypeOfValue.waiste:
        typeOfValueString = "НОВЫЙ ОБЪЕМ";
        break;
      default:
        break;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackgroindGradientStart,
        appBar: MyCustomAppBar(
          height: sizeScreen.height * 0.2,
          header: typeOfValueString,
          rightAppbarButton: RightAppbarButton.empty,
          leftAppbarButton: LeftAppbarButton.backArrow,
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
                    controller: textController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите значение";
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r"^\d+\.?\d{0,1}"))
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
                      hintText: 'Результат замера',
                      // enabled: checkController.getWaisteChecking
                      //     ? true
                      //     : false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 300, height: 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 5, primary: colorButtons),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          //* save data via provider and go to dashboard
                          if (widget.typeOfValue ==
                              ChoosingTypeOfValue.weight) {
                            WeightsController weightController = Get.find();
                            weightController
                                .addWeight(double.parse(textController.text));
                            // final providerWeight = watch(weightNotifierProvider);
                            // providerWeight.addWeight(double.parse(
                            //     textController.text.toString()));
                            // context.read(weightNotifierProvider.notifier).addWeight(double.parse(textController.text.toString()));
                          }
                          if (widget.typeOfValue ==
                              ChoosingTypeOfValue.waiste) {
                            // final providerWaiste = watch(waisteProvider);
                            // providerWaiste.addWaiste(double.parse(
                            //     textController.text.toString()));

                            WaisteController waisteController = Get.find();
                            waisteController
                                .addWaiste(double.parse(textController.text));
                          }

                          Navigator.pop(context);
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
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
