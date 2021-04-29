import 'package:ctrl_weight/services/database.dart';
import 'package:get/get.dart';

class WeightsController extends GetxController {
  final database = Database();

  var weightsList = <double>[].obs;

  var timeList = <DateTime>[].obs;

  var wantedWeight = 0.0.obs;

  Future<void> addWeight(double value) async {
    await database.addWeight(value);
    weightsList.add(value);
    timeList.add(DateTime.now());
    update();
  }

  Future<void> saveWantedWeight(double value) async {
    await database.saveWantedWeight(value);
    wantedWeight.value = value;
    print("|WeightController|saveWantedWeight\t wantedWeight = $wantedWeight");
  }

  double getWantedWeight() {
    return wantedWeight.value;
  }
}
