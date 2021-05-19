import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:ctrl_weight/controllers/waisteController.dart';
import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class WaisteCard extends StatefulWidget {
  WaisteCard({Key key, this.dateTime, this.index, this.waiste, this.prevWaiste})
      : super(key: key);

  final DateTime dateTime;
  final int index;
  final double waiste;
  final double prevWaiste;

  @override
  _WaisteCardState createState() => _WaisteCardState();
}

class _WaisteCardState extends State<WaisteCard> {
  TextEditingController _textFieldController = TextEditingController();

  _displayDialogCorrection(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Корректировка значения'),
            content: TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d{0,1}"))
              ],
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Введите значение"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Отмена",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop("SAVING");
                },
                child: Text(
                  "Сохранить",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var diff = widget.waiste - widget.prevWaiste;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorAppBarGradientEnd,
                colorAppBarGradientStart,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: <Widget>[
              Text(
                DateFormat("dd.MM.yyyy").format(widget.dateTime).toString(),
                style: TextStyle(fontSize: 12, color: colorTextInWhitePanels),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.waiste.toStringAsFixed(1),
                      style: TextStyle(
                          fontSize: 24, color: colorTextInWhitePanels),
                    ),
                    widget.prevWaiste == -1
                        ? Container()
                        : diff >= 0
                            ? Text(
                                "+${diff.toStringAsFixed(1)}",
                                style: TextStyle(color: Colors.red),
                              )
                            : Text(
                                diff.toStringAsFixed(1),
                                style: TextStyle(color: Colors.green),
                              ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[200],
                      ),
                      onPressed: () async {
                        var r = await showOkCancelAlertDialog(
                          context: context,
                          title: "Предупреждение",
                          message:
                              "Действительно удалить запись ${widget.waiste.toStringAsFixed(1)} кг?",
                          okLabel: "Удалить",
                          alertStyle: AdaptiveStyle.material,
                          cancelLabel: "Отмена",
                          defaultType: OkCancelAlertDefaultType.cancel,
                        );
                        if (r == OkCancelResult.ok) {
                          WaisteController waisteController = Get.find();
                          waisteController.deleteWaiste(widget.index);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () async {
                        _textFieldController.text =
                            widget.waiste.toStringAsFixed(1);
                        var r = await _displayDialogCorrection(context);
                        if (r == "SAVING") {
                          WaisteController waisteController = Get.find();
                          waisteController.updateWaiste(
                            widget.index,
                            double.parse(_textFieldController.text),
                            widget.dateTime,
                          );
                        }
                      },
                      icon: Icon(
                        Boxicons.bxs_edit,
                        color: colorButtons,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
