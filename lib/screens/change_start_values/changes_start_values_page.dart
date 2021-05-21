import 'package:another_flushbar/flushbar.dart';
import 'package:ctrl_weight/controllers/waisteController.dart';
import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeStartValuesPage extends StatefulWidget {
  const ChangeStartValuesPage({Key key}) : super(key: key);

  @override
  _ChangeStartValuesPageState createState() => _ChangeStartValuesPageState();
}

class _ChangeStartValuesPageState extends State<ChangeStartValuesPage> {
  static GlobalKey<FormState> _formKeyWantedWeight = new GlobalKey<FormState>();
  static GlobalKey<FormState> _formKeyHeight = new GlobalKey<FormState>();
  final textWeightController = TextEditingController();
  final textHeightController = TextEditingController();
  WeightsController weightsController = Get.find();
  WaisteController waisteController = Get.find();

  bool _saveWantedWeightButton = false;
  bool _saveHeightButton = false;

  @override
  void initState() {
    textWeightController.text =
        weightsController.wantedWeight.value.toStringAsFixed(1);

    textHeightController.text = waisteController.height.toStringAsFixed(1);

    super.initState();
  }

  @override
  void dispose() {
    textHeightController.dispose();
    textWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //* textController and position of cursor to the end of the value

    textWeightController.selection = TextSelection.fromPosition(
        TextPosition(offset: textWeightController.text.length));

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackgroindGradientStart,
        appBar: MyCustomAppBar(
          height: size.height * 0.2,
          header: "НАЧАЛЬНЫЕ ЗНАЧЕНИЯ",
          rightAppbarButton: RightAppbarButton.empty,
          leftAppbarButton: LeftAppbarButton.backArrow,
        ),
        body: Container(
          height: double.infinity,
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
            child: Form(
              key: _formKeyWantedWeight,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Желаемый вес",
                      style: GoogleFonts.play(
                        color: colorTextIcons,
                        fontSize: 18,
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
                      onChanged: (textValue) {
                        TextEditingValue(text: textValue);
                      },
                      controller: textWeightController,
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
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() {
                          textWeightController.text = value;
                        });
                      },
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
                        enabled: _saveWantedWeightButton ? false : true,
                        hintText: 'Желаемый вес, кг',

                        // enabled: checkController.getWaisteChecking
                        //     ? true
                        //     : false,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 300, height: 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          primary: _saveWantedWeightButton
                              ? Colors.green
                              : colorButtons),
                      onPressed: () async {
                        setState(() {
                          _saveWantedWeightButton = true;
                          weightsController.saveWantedWeight(
                              double.parse(textWeightController.text));
                        });

                        await Flushbar(
                          icon: Icon(
                            Boxicons.bx_check,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 3),
                          title: "Значение изменено",
                          message:
                              "Желаемый вес: ${weightsController.wantedWeight.value.toStringAsFixed(1)}",
                        ).show(context);
                      },
                      child: Text(
                        _saveWantedWeightButton ? "Сохранено" : "Изменить вес",
                        style: GoogleFonts.play(
                          color: colorTextIcons,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Text(
                      "Рост",
                      style: GoogleFonts.play(
                        color: colorTextIcons,
                        fontSize: 18,
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
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() {
                          textHeightController.text = value;
                        });
                      },
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
                        enabled: _saveHeightButton ? false : true,

                        // enabled: checkController.getWaisteChecking
                        //     ? true
                        //     : false,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 300, height: 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          primary:
                              _saveHeightButton ? Colors.green : colorButtons),
                      onPressed: () async {
                        setState(() {
                          _saveHeightButton = true;
                          waisteController.calculateWantedWaiste(
                              double.parse(textHeightController.text));
                        });

                        await Flushbar(
                          icon: Icon(
                            Boxicons.bx_check,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 3),
                          title: "Значение изменено",
                          message:
                              "Желаемый объем талии пересчитан: ${((double.parse(textHeightController.text)) * 0.49).toStringAsFixed(1)}",
                        ).show(context);
                      },
                      child: Text(
                        _saveHeightButton ? "Сохранено" : "Изменить рост",
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
      ),
    );
  }
}
