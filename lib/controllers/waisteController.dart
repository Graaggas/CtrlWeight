import 'package:ctrl_weight/services/database.dart';
import 'package:get/get.dart';

class WaisteController extends GetxController {
  final database = Database();

  var waisteList = <double>[].obs;

  var timeList = <DateTime>[].obs;

  var wantedWaiste = 0.0.obs;

  final double height = 0;

  var currentWaiste = 0.0.obs;

  var startWaiste = 0.0.obs;

  Future<void> addWaiste(double value) async {
    await database.addWaiste(value);
    if(waisteList.isEmpty){
      startWaiste.value = value;
    }
    waisteList.add(value);
    timeList.add(DateTime.now());
    currentWaiste.value = value;
    update();
  }




}
