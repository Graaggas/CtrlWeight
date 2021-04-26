import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';

enum ChoosingTypeOfValue {
  weight,
  waiste,
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String header;

  const MyCustomAppBar({
    Key key,
    @required this.height,
    this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     colorBackgroindGradientEnd,
          //     colorBackgroindGradientMiddle,
          //     colorBackgroindGradientStart,
          //   ],
          //   begin: const FractionalOffset(0.0, 0.0),
          //   end: const FractionalOffset(0.0, 4.0),
          //   // stops: [0.0, 1.0],
          //   tileMode: TileMode.clamp,
          // ),
          ),
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorAppBarGradientStart,
                  colorAppBarGradientEnd,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
              // color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          padding: EdgeInsets.all(5),
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                  color: colorAppBarButtons,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: IconButton(
                icon: Icon(
                  Boxicons.bx_menu,
                  color: colorTextIcons,
                ),
                onPressed: () {
                  //Scaffold.of(context).openDrawer();
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: Text(
                      header,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.play(
                        color: colorTextIcons,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: colorAppBarButtons,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: IconButton(
                icon: Icon(
                  Boxicons.bx_plus,
                  color: colorTextIcons,
                ),
                onPressed: () async {
                  var r = await showModalActionSheet(
                    context: context,
                    actions: [
                      SheetAction(
                        icon: Boxicons.bx_tachometer,
                        label: "Добавить результаты взвешивания",
                        key: ChoosingTypeOfValue.weight,
                      ),
                      SheetAction(
                        key: ChoosingTypeOfValue.waiste,
                        label: "Добавить результаты измерения объема талии",
                        icon: Boxicons.bx_ruler,
                      ),
                    ],
                  );
                  switch (r) {
                    case ChoosingTypeOfValue.waiste:
                      print("|CustomAppBar| adding new waiste choosed...");
                      var dialog = await showTextInputDialog(
                          context: context,
                          title: "Добавить результаты измерения объема талии",
                          textFields: [
                            DialogTextField(
                              //TODO добавить валидатор
                              initialText: "",
                              keyboardType: TextInputType.number,
                            ),
                          ]);
                      break;
                    case ChoosingTypeOfValue.weight:
                      print("|CustomAppBar| adding new weight choosed...");
                      break;
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
