import 'package:ctrl_weight/misc/colors.dart';
import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Расчет идеального объема талии складывается из индекса центрального ожирения. В основе метода лежит вычисление индекса WhtR - соотношение роста и объема талии. Этот индекс должен составлять менее 0.5. Достаточно ввести Ваш рост на следующем экране и этот индекс будет посчитан автоматически. Вам будет только необходимо вести контроль объема талии, приближаясь к идеальному значению.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: colorTextInWhitePanels,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "assets/waiste.png",
            ),
          ),
        ],
      ),
    );
  }
}
