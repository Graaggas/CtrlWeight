import 'package:ctrl_weight/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyCustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                    icon: Icon(Icons.menu),
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
                          "НАЧАЛЬНЫЕ ЗНАЧЕНИЯ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.play(
                            color: colorTextInPanels,
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
                    icon: Icon(Icons.verified_user),
                    onPressed: () => null,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
