import 'package:ctrl_weight/services/database.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class WeightsController extends GetxController {
  final database = Database();

  var weightsList = <double>[].obs;

  var timeList = <DateTime>[].obs;

  var wantedWeight = 0.0.obs;

  var currentWeight = 0.0.obs;

  var startWeight = 0.0.obs;

  var diffWeight = 0.0.obs;

  var averageWeightAllDays = 0.0.obs;

  var averageWeightSevenDays = 0.0.obs;

  var averageWeightFourteenDays = 0.0.obs;

  var averageWeightMonth = 0.0.obs;

  Future<void> getSevenDaysAverage(
      {RxList<DateTime> timeDateList,
      RxList<double> valuesList,
      RxDouble averageRx}) async {
    double average = 0.0;
    double diff = 0.0;

    var cuDay = timeDateList[timeDateList.length - 1];

    var currentDay = Jiffy(cuDay);

    var now = Jiffy(DateTime.now());

    var firstOfSevenDay = now.subtract(days: 7);

    List<double> list = [];
    for (int i = 0; i < timeDateList.length; i++) {
      var r = Jiffy(timeDateList[i]);

      if (r.isBetween(firstOfSevenDay, currentDay.add(days: 1))) {
        list.add(valuesList[i]);
      }
    }

    for (int i = 1; i < list.length; i++) {
      diff = list[i] - list[i - 1];
      // print("||weightController||getSevenDaysAverage||\n diff: $diff\n\n");
      average = average + diff;
      // print(
      //     "||weightController||getSevenDaysAverage||\n average: $average\n\n");
    }

    averageRx.value = average;
    // print(
    //     "||weightController||getSevenDaysAverage||\n averageWeightSevenDays: ${averageWeightSevenDays.value}\n\n");
    update();
  }

  void getWeightsDiff() {
    if (weightsList.length == 1) {
      diffWeight.value = 0.0;
    } else if (weightsList.isNotEmpty) {
      diffWeight.value =
          currentWeight.value - weightsList[weightsList.length - 2];
    }
  }

  Future<void> deleteWeight(int index) async {
    await database.deleteWeight(index);
    weightsList.removeAt(index);
    timeList.removeAt(index);
    if (weightsList.isNotEmpty) {
      currentWeight.value = weightsList.last;
    } else {
      currentWeight.value = 0;
    }

    print(
        "|WeightController|deleteWeight\t after deleting currentWeight = ${currentWeight.value}");

    if (index == 0) {
      if (weightsList.isNotEmpty) {
        startWeight.value = weightsList.first;
      } else
        startWeight.value = 0.0;
    }
    update();
    getWeightsDiff();
    getSevenDaysAverage(
      valuesList: weightsList,
      timeDateList: timeList,
      averageRx: averageWeightSevenDays,
    );
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
    getSevenDaysAverage(
      valuesList: weightsList,
      timeDateList: timeList,
      averageRx: averageWeightSevenDays,
    );
  }

  Future<void> saveWantedWeight(double value) async {
    await database.saveWantedWeight(value);
    wantedWeight.value = value;
    print("|WeightController|saveWantedWeight\t wantedWeight = $wantedWeight");
    update();
  }

  Future<void> updateWeight(int index, double value, DateTime date) async {
    await database.updateWeight(value, date);
    currentWeight.value = value;
    weightsList[index] = value;
    update();
    getWeightsDiff();
    getSevenDaysAverage(
      valuesList: weightsList,
      timeDateList: timeList,
      averageRx: averageWeightSevenDays,
    );
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
    update();
    getWeightsDiff();
    getSevenDaysAverage(
      valuesList: weightsList,
      timeDateList: timeList,
      averageRx: averageWeightSevenDays,
    );
  }

  @override
  void onReady() {
    print("===> Widget with weightController was rendered");
    super.onReady();
  }
}
