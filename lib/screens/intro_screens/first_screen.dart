import 'package:ctrl_weight/misc/colors.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Добро пожаловать!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: colorTextInWhitePanels,
          ),
        ),
        Image.asset(
          "assets/logo.png",
        ),
        Text(
          "CTRL WEIGHT",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorTextInPanels,
          ),
        ),
      ],
    ));
  }
}
