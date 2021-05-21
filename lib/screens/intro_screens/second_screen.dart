import 'package:ctrl_weight/misc/colors.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "assets/screens.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Вы можете вести дневник наблюдений за изменениями веса и объема талии.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: colorTextInWhitePanels,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
