import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class StartValuesScreen extends StatefulWidget {
  @override
  _StartValuesScreenState createState() => _StartValuesScreenState();
}

class _StartValuesScreenState extends State<StartValuesScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackgroindGradientStart,
        appBar: MyCustomAppBar(
          height: size.height * 0.103,
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
              end: const FractionalOffset(0.0, 4.0),
              // stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Введите значение";
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d{0,2}"))
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Введите значение";
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d{0,2}"))
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5, primary: colorButtons),
                onPressed: () {},
                child: Text(
                  "Добавить",
                  style: GoogleFonts.play(
                    color: colorTextIcons,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
