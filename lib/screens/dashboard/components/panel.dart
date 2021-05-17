import 'package:ctrl_weight/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Panel extends StatelessWidget {
  const Panel({
    Key key,
    @required this.size,
    this.currentText,
    this.currentDiff,
    this.measure,
    this.valueOfFill,
    this.startValue,
    this.wantedValue,
    this.colorStart,
    this.colorEnd,
    this.typeOfProvider,
    this.currentValue,
  }) : super(key: key);

  final Size size;
  final String currentText;
  final double currentValue;
  final double currentDiff;
  final String measure;
  final double valueOfFill;
  final double startValue;
  final double wantedValue;
  final Color colorStart;
  final Color colorEnd;
  final String typeOfProvider;

  @override
  Widget build(BuildContext context) {
    GlobalKey _keyWeight = GlobalKey();

    // final futureCurrentValue = watch(typeOfProvider);

    getSizeOfWeightProgress() {
      final RenderBox renderBoxWeight =
          _keyWeight.currentContext.findRenderObject();
      final sizeWeight = renderBoxWeight.size;
    }

    return Padding(
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
        // height: size.height / 3,
        width: size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  currentText,
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
                  "$currentValue $measure",
                  style: GoogleFonts.play(
                    color: colorTextInPanels,
                    fontSize: 32,
                  ),
                ),

                //  Text(
                //   "${currentValue.toString()} $measure",
                //   style: GoogleFonts.play(
                //     color: colorTextInPanels,
                //     fontSize: 32,
                //   ),
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: currentDiff <= 0 ? colorGreenDiff : colorRedDiff,
                  // border: Border.all(color: colorTextInWhitePanels),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: currentDiff <= 0
                        ? Text(
                            currentDiff.toStringAsFixed(2),
                            style: GoogleFonts.play(
                              color: colorTextInWhitePanels,
                              fontSize: 20,
                            ),
                          )
                        : Text(
                            "+${currentDiff.toStringAsFixed(2)}",
                            style: GoogleFonts.play(
                              color: colorTextInWhitePanels,
                              fontSize: 20,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: Row(
                children: [
                  Text(
                    "$startValue$measure",
                    style: GoogleFonts.play(
                      color: colorTextInWhitePanels,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "$wantedValue$measure",
                    style: GoogleFonts.play(
                      color: colorTextInWhitePanels,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 8, bottom: 32),
              child: Stack(
                children: [
                  Container(
                    key: _keyWeight,
                    height: size.height / 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                  ),
                  //строим лэйаут, чтобы узнать размеры верхнего окна
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraint) {
                      getSizeOfWeightProgress();
                      return Container(
                        height: size.height / 60,
                        width: constraint.maxWidth / valueOfFill,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            colorStart,
                            colorEnd,
                          ]),
                          borderRadius: BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
