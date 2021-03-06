import 'package:ctrl_weight/controllers/waisteController.dart';
import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  final BuildContext context2;
  const CustomDrawer({
    Key key,
    this.context2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeightsController weightsController = Get.find();
    WaisteController waisteController = Get.find();

    return Drawer(
      elevation: 6,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('logo.png'),
                fit: BoxFit.scaleDown,
              ),
              gradient: LinearGradient(
                colors: [
                  colorBackgroindGradientEnd,
                  colorBackgroindGradientMiddle,
                  colorBackgroindGradientStart
                ],
              ),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.home),
          //   title: Text(
          //     "ПАНЕЛЬ ДАННЫХ",
          //     style: TextStyle(
          //       fontSize: 16,
          //     ),
          //   ),
          //   onTap: () {
          //     Get.toNamed("/dashboard_screen");
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text(
              "Вес",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.pop(context2);
              Get.toNamed("/weights_screen");
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text(
              "Объем талии",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.pop(context2);
              Get.toNamed("/waistes_screen");
            },
          ),

          ListTile(
            leading: Icon(Boxicons.bx_chart),
            title: Text(
              "Графики",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              weightsController.averAlldays.value = true;
              waisteController.averAlldays.value = true;

              Navigator.pop(context2);
              Get.toNamed("/charts_screen");
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text(
              "Начальные данные",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.pop(context2);
              Get.toNamed("/change_start_values_screen");
              // Get.toNamed("/dashboard_screen");
            },
          ),
        ],
      ),
    );
  }
}
