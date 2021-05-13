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
    return Drawer(
      elevation: 6,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
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
              "ТАБЛИЦА ВЕСОВ",
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
              "ТАБЛИЦА ОБЪЕМОВ",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Boxicons.bx_chart),
            title: Text(
              "ГРАФИКИ",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.pop(context2);
              Get.toNamed("/charts_screen");
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text(
              "НАЧАЛЬНЫЕ ДАННЫЕ",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              // Get.toNamed("/dashboard_screen");
            },
          ),
        ],
      ),
    );
  }
}
