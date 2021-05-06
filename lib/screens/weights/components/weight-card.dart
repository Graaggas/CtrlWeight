import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WeightCard extends StatelessWidget {
  const WeightCard(
      {Key key, this.dateTime, this.index, this.weight, this.prevWeight})
      : super(key: key);

  final DateTime dateTime;
  final int index;
  final double weight;
  final double prevWeight;

  @override
  Widget build(BuildContext context) {
    var diff = weight - prevWeight;
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
                DateFormat("dd.MM.yyyy").format(dateTime).toString(),
                style: TextStyle(fontSize: 12, color: colorTextInWhitePanels),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weight.toString(),
                      style: TextStyle(
                          fontSize: 24, color: colorTextInWhitePanels),
                    ),
                    prevWeight == -1
                        ? Container()
                        : diff >= 0
                            ? Text(
                                "+${diff.toStringAsFixed(2)}",
                                style: TextStyle(color: Colors.red),
                              )
                            : Text(
                                diff.toStringAsFixed(2),
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
                              "Действительно удалить запись с весом ${weight.toString()} кг?",
                          okLabel: "Удалить",
                          alertStyle: AdaptiveStyle.material,
                          cancelLabel: "Отмена",
                          defaultType: OkCancelAlertDefaultType.cancel,
                        );
                        if (r == OkCancelResult.ok) {
                          WeightsController weightsController = Get.find();
                          weightsController.deleteWeight(index);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Boxicons.bxs_edit,
                      color: colorButtons,
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
