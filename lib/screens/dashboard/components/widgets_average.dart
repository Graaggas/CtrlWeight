import 'package:ctrl_weight/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetAverage extends StatelessWidget {
  const WidgetAverage({
    Key key,
    @required this.sizeScreen,
    this.typeOfAverage,
    this.weightAverage,
    this.waisteAverage,
  }) : super(key: key);

  final Size sizeScreen;
  final String typeOfAverage;
  final double weightAverage;
  final double waisteAverage;

  @override
  Widget build(BuildContext context) {
    String averWeight = "...";
    String averWaiste = "...";
    if (weightAverage == null) {
      averWeight = "";
    } else {
      if (weightAverage > 0)
        averWeight = "+" + weightAverage.toStringAsFixed(1);
      else
        averWeight = weightAverage.toStringAsFixed(1);
    }

    if (waisteAverage == null) {
      averWaiste = "";
    } else {
      if (waisteAverage > 0) {
        averWaiste = "+" + waisteAverage.toStringAsFixed(1);
      } else {
        averWaiste = waisteAverage.toStringAsFixed(1);
      }
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Positioned.fill(
        //   child: Container(color: Colors.grey, child: Text('foo')),
        // ),
        AverageContainer(sizeScreen: sizeScreen),
        Positioned(
          child: Container(
            height: sizeScreen.width / 2.5,
            width: sizeScreen.width / 2.5,
            alignment: Alignment.center,
            // color: Colors.blue[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: CustomPaint(
                        size:
                            Size(sizeScreen.width / 3.5, sizeScreen.width / 10),
                        painter: ContainerAveragePeriod(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Text(
                        typeOfAverage,
                        style: GoogleFonts.play(
                          color: colorAppBarGradientEnd,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "$averWeight кг",
                  style: GoogleFonts.play(
                    color: colorTextInWhitePanels,
                    fontSize: 22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey[300],
                    height: 2,
                    width: sizeScreen.width / 4,
                  ),
                ),
                Text(
                  "$averWaiste см",
                  style: GoogleFonts.play(
                    color: colorTextInWhitePanels,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      // alignment: Alignment.topCenter,
      // children: [
      //   AverageContainer(sizeScreen: sizeScreen),
      //   Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Stack(
      //         alignment: Alignment.topCenter,
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.only(top: 16.0),
      //             child: CustomPaint(
      //               size: Size(sizeScreen.width / 3.5, sizeScreen.width / 10),
      //               painter: ContainerAveragePeriod(),
      //             ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(top: 25.0),
      //             child: Text(
      //               typeOfAverage,
      //               style: GoogleFonts.play(
      //                 color: colorAppBarGradientEnd,
      //                 fontSize: 20,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Text(
      //         "+13 кг",
      //         style: GoogleFonts.play(
      //           color: colorTextInWhitePanels,
      //           fontSize: 18,
      //         ),
      //       ),
      //       Container(
      //         color: Colors.grey[300],
      //         height: 2,
      //         width: sizeScreen.width / 4,
      //       ),
      //       Text(
      //         "-9 см",
      //         style: GoogleFonts.play(
      //           color: colorTextInWhitePanels,
      //           fontSize: 18,
      //         ),
      //       ),
      //     ],
      //   ),
      //
      //],
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
      painter: PainterForAverageContainer(),
    );
  }
}

class PainterForAverageContainer extends CustomPainter {
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

class ContainerAveragePeriod extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = colorPanel
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0500000, size.height * 0.1000000);
    path_0.quadraticBezierTo(size.width * 0.1060000, size.height * -0.0058000,
        size.width * 0.2500000, 0);
    path_0.lineTo(size.width * 0.5000000, 0);
    path_0.lineTo(size.width * 0.7500000, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height * 0.5000000);
    path_0.quadraticBezierTo(size.width * 0.9994500, size.height * 0.8000000,
        size.width * 0.9500000, size.height * 0.9000000);
    path_0.quadraticBezierTo(size.width * 0.9012000, size.height * 0.9964000,
        size.width * 0.7500000, size.height);
    path_0.lineTo(size.width * 0.5000000, size.height);
    path_0.lineTo(size.width * 0.2500000, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.5000000);
    path_0.quadraticBezierTo(size.width * -0.0007000, size.height * 0.2001000,
        size.width * 0.0500000, size.height * 0.1000000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
