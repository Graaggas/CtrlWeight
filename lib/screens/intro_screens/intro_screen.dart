import 'package:ctrl_weight/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _pageController;
  List<Widget> slideList;
  int initialPage = 1;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final database = Database();

    return SafeArea(
      child: GFIntroScreen(
        color: Colors.blueGrey,
        slides: [
          Container(
            child: Scaffold(
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
                child: Center(
                  child: Text("111"),
                ),
              ),
            ),
          ),
          Container(
            child: Scaffold(
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
                  child: Center(
                    child: Text("222"),
                  )),
            ),
          ),
          Container(
            child: Scaffold(
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
                  child: Center(
                    child: Text("333"),
                  )),
            ),
          ),
        ],
        pageController: _pageController,
        currentIndex: 3,
        pageCount: 3,
        introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
          forwardButton: Icon(Boxicons.bx_right_arrow),
          skipButtonText: "ОТМЕНА",
          onSkipTap: () {
            // database.changeFirstMeetingFlagToFalse();
            Navigator.pushReplacementNamed(context, '/start_values_screen');
          },
          backButton: Icon(Boxicons.bx_left_arrow),
          doneButtonText: "ГОТОВО",
          skipButtonTextStyle: GoogleFonts.play(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          doneButtonTextStyle: GoogleFonts.play(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          onDoneTap: () {
            // database.changeFirstMeetingFlagToFalse();

            Navigator.pushReplacementNamed(context, '/start_values_screen');
          },
          pageController: _pageController,
          pageCount: 3,
          currentIndex: 3,
          onForwardButtonTap: () {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          },
          onBackButtonTap: () {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          },
          navigationBarColor: Colors.white,
          showDivider: false,
          inactiveColor: Colors.grey[200],
          activeColor: GFColors.SUCCESS,
        ),
      ),
    );
  }
}
