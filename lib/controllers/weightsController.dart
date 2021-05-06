import 'package:ctrl_weight/services/database.dart';
import 'package:get/get.dart';

class WeightsController extends GetxController {
  final database = Database();

  var weightsList = <double>[].obs;

  var timeList = <DateTime>[].obs;

  var wantedWeight = 0.0.obs;

  var currentWeight = 0.0.obs;

  var startWeight = 0.0.obs;

  var diffWeight = 0.0.obs;

  void getWeightsDiff() {
    if (weightsList.length == 1) {
      diffWeight.value = 0.0;
    } else {
      diffWeight.value =
          currentWeight.value - weightsList[weightsList.length - 2];
    }
  }

  Future<void> deleteWeight(int index) async {
    await database.deleteWeight(index);
    weightsList.removeAt(index);
    if (weightsList.isNotEmpty) {
      currentWeight.value = weightsList.last;
    } else {
      currentWeight.value = 0;
    }

    print(
        "|WeightController|deleteWeight\t after deleting currentWeight = ${currentWeight.value}");

    update();
    getWeightsDiff();
  }

  Future<void> addWeight(double value) async {
    await database.addWeight(value);
    if (weightsList.isEmpty) {
      startWeight.value = value;
    }
    weightsList.add(value);
    timeList.add(DateTime.now());
    currentWeight.value = value;
    update();
    getWeightsDiff();
  }

  Future<void> saveWantedWeight(double value) async {
    await database.saveWantedWeight(value);
    wantedWeight.value = value;
    print("|WeightController|saveWantedWeight\t wantedWeight = $wantedWeight");
    update();
  }

  // double getWantedWeight() {
  //   return wantedWeight.value;
  // }

  @override
  void onInit() async {
    print("===> try to init weightController");
    wantedWeight.value = await database.getWantedWeight();
    print("|WeightController|onInit: wantedWeight = ${wantedWeight.value}");

    weightsList.value = await database.getWeights();
    print("|WeightController|onInit: weightsList = $weightsList");

    timeList.value = await database.getTimeWeights();
    print("|WeightController|onInit: timeList = $timeList");

    var r = await database.getWeights();
    if (r.isNotEmpty) {
      startWeight.value = r.first;
      print("|WeightController|onInit: startWeight = ${startWeight.value}");
      currentWeight.value = r.last;
      print("|WeightController|onInit: currentWeight = ${currentWeight.value}");
    }

    super.onInit();
  }

  @override
  void onReady() {
    print("===> Widget with weightController was rendered");
    super.onReady();
  }
}
