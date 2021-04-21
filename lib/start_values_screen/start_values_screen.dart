import 'package:flutter/material.dart';

class StartValuesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyCustomAppBar(
          height: 150,
        ),
        body: Center(
          child: Text("START VALUES SCREEN"),
        ),
      ),
    );
  }
}

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
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              padding: EdgeInsets.all(5),
              child: Row(children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    //Scaffold.of(context).openDrawer();
                  },
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey,
                    child: Text(
                      "HIGHLIGHT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.verified_user),
                  onPressed: () => null,
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
