import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackgroindGradientStart,
        appBar: MyCustomAppBar(
          height: size.height * 0.2,
          header: "ПАНЕЛЬ ДАННЫХ",
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 32.0,
                  right: 32.0,
                  top: 16,
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorAppBarGradientEnd,
                    borderRadius: BorderRadius.all(
                      Radius.circular(28.0),
                    ),
                    boxShadow: [
                      // color: Colors.white, //background color of box
                      BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 12.0, // soften the shadow
                        spreadRadius: 3.0, //extend the shadow
                        offset: Offset(
                          2.0, // Move to right 10  horizontally
                          2.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  // width: size.width /1.1,
                  //height: size.height / 4.5,
                  height: size.height / 4,
                  width: size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "ТЕКУЩИЙ ВЕС",
                            style: GoogleFonts.play(
                              color: colorTextInWhitePanels,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            "138.1 кг",
                            style: GoogleFonts.play(
                              color: colorTextInPanels,
                              fontSize: 32,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorGreenDiff,
                            // border: Border.all(color: colorTextInWhitePanels),
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "- 16.4",
                                style: GoogleFonts.play(
                                  color: colorTextInWhitePanels,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
