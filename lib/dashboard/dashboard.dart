import 'dart:math';

import 'package:ctrl_weight/dashboard/components/panel.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:ctrl_weight/misc/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackgroindGradientStart,
        appBar: MyCustomAppBar(
          height: sizeScreen.height * 0.2,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Panel(
                  size: sizeScreen,
                  currentText: "ТЕКУЩИЙ ВЕС",
                  currentValue: 138.2,
                  currentDiff: -12.01,
                  measure: " кг",
                  valueOfFill: 2,
                  startValue: 130,
                  wantedValue: 90,
                  colorStart: colorWeightProgressLineEnd,
                  colorEnd: colorWeightProgressLineStart,
                ),
                Panel(
                  size: sizeScreen,
                  currentText: "ТЕКУЩИЙ ОБЪЕМ",
                  currentValue: 111.02,
                  currentDiff: 11.1,
                  measure: " см",
                  valueOfFill: 3,
                  startValue: 112,
                  wantedValue: 101,
                  colorStart: colorWaisteProgressLineStart,
                  colorEnd: colorWaistePRogressLineEnd,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 32.0, top: 16, right: 32),
                  child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WidgetAverage(sizeScreen: sizeScreen),
                          WidgetAverage(sizeScreen: sizeScreen),
                        ],
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

class WidgetAverage extends StatelessWidget {
  const WidgetAverage({
    Key key,
    @required this.sizeScreen,
  }) : super(key: key);

  final Size sizeScreen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AverageContainer(sizeScreen: sizeScreen),
        Positioned(
          top: 10,
          left: 35,
          child: Container(
            decoration: BoxDecoration(
              color: colorPanel,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "НЕДЕЛЯ",
                style: GoogleFonts.play(
                  color: colorAppBarGradientEnd,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AverageContainer extends StatelessWidget {
  const AverageContainer({
    Key key,
    @required this.sizeScreen,
  }) : super(key: key);

  final Size sizeScreen;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(sizeScreen.width / 2.5, sizeScreen.width / 2.5),
      painter: RPSCustomPainter(),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = colorAppBarGradientEnd
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1000000, size.height * 0.1000000);
    path_0.quadraticBezierTo(size.width * 0.2008333, size.height * 0.0008667,
        size.width * 0.3333333, 0);
    path_0.lineTo(size.width * 0.8333333, 0);
    path_0.quadraticBezierTo(size.width * 0.9352000, size.height * -0.0010000,
        size.width * 0.9666667, size.height * 0.0333333);
    path_0.quadraticBezierTo(size.width * 0.9982000, size.height * 0.0666667,
        size.width, size.height * 0.1666667);
    path_0.lineTo(size.width, size.height * 0.6666667);
    path_0.quadraticBezierTo(size.width * 0.9990333, size.height * 0.8009667,
        size.width * 0.9000000, size.height * 0.9000000);
    path_0.quadraticBezierTo(size.width * 0.8018667, size.height * 1.0001333,
        size.width * 0.6666667, size.height);
    path_0.lineTo(size.width * 0.1666667, size.height);
    path_0.quadraticBezierTo(size.width * 0.0675333, size.height * 1.0020000,
        size.width * 0.0333333, size.height * 0.9666667);
    path_0.quadraticBezierTo(size.width * 0.0017667, size.height * 0.9324667, 0,
        size.height * 0.8333333);
    path_0.lineTo(0, size.height * 0.3333333);
    path_0.quadraticBezierTo(0, size.height * 0.2036667, size.width * 0.1000000,
        size.height * 0.1000000);
    path_0.close();

    canvas.drawShadow(path_0, Colors.grey[200], 4, true);
    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
