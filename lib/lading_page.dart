import 'package:ctrl_weight/controllers/firstMeetingFlagController.dart';
import 'package:ctrl_weight/screens/dashboard/dashboard.dart';
import 'package:ctrl_weight/screens/intro_screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirstMeetingFlagController flagController = Get.find();



    return FutureBuilder<bool>(
        future: flagController.getFlagFromHive(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("|LandingPage| flag = ${snapshot.data}");
            return snapshot.data == true
                ? IntroScreen()
                : DashboardScreen();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
