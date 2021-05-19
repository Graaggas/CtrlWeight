import 'package:ctrl_weight/misc/avers.dart';
import 'package:ctrl_weight/misc/chart_data.dart';
import 'package:ctrl_weight/services/database.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class WeightsController extends GetxController {
  final database = Database();

  var averAlldays = false.obs;
  var averSevenDays = false.obs;
  var averMonth = false.obs;

  var weightsChartList = <WeightChart>[].obs;

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

  void changeAverAllDays(bool value) {
    print("CHANGING AVERALLDAYS = $value");
    averAlldays.value = value;
    update();
  }

  void changeAverMonth(bool value) {
    print("CHANGING AverMonth = $value");
    averMonth.value = value;
    update();
  }

  void changeAverSevenDays(bool value) {
    print("CHANGING SEVENDAYS = $value");
    averSevenDays.value = value;
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

//*+
  Future<void> deleteWeight(int index) async {
    await database.deleteWeight(index);
    weightsList.removeAt(index);
    timeList.removeAt(index);
    if (weightsList.isNotEmpty) {
      currentWeight.value = weightsList.last;
    } else {
      currentWeight.value = 0;
    }
    print("index of deleting = $index");

    // print(
    //     "|WeightController|deleteWeight\t after deleting currentWeight = ${currentWeight.value}");

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
    getMonthsAverage(
      valuesList: weightsList,
      timeDatesList: timeList,
      averageRX: averageWeightMonth,
    );
    getFourteenDaysAverage(
      valuesList: weightsList,
      listOfDates: timeList,
      averageRx: averageWeightFourteenDays,
    );
    getAllDaysAverage(
      averageRx: averageWeightAllDays,
      listOfDates: timeList,
      valuesList: weightsList,
    );
    updateWeightChartList();
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
    getMonthsAverage(
      valuesList: weightsList,
      timeDatesList: timeList,
      averageRX: averageWeightMonth,
    );
    getFourteenDaysAverage(
      valuesList: weightsList,
      listOfDates: timeList,
      averageRx: averageWeightFourteenDays,
    );
    getAllDaysAverage(
      averageRx: averageWeightAllDays,
      listOfDates: timeList,
      valuesList: weightsList,
    );
    updateWeightChartList();
  }

  Future<void> saveWantedWeight(double value) async {
    await database.saveWantedWeight(value);
    wantedWeight.value = value;
    print("|WeightController|saveWantedWeight\t wantedWeight = $wantedWeight");
    update();
  }

//*+
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
    getMonthsAverage(
      valuesList: weightsList,
      timeDatesList: timeList,
      averageRX: averageWeightMonth,
    );
    getFourteenDaysAverage(
      valuesList: weightsList,
      listOfDates: timeList,
      averageRx: averageWeightFourteenDays,
    );
    getAllDaysAverage(
      averageRx: averageWeightAllDays,
      listOfDates: timeList,
      valuesList: weightsList,
    );
    updateWeightChartList();
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
    getMonthsAverage(
      valuesList: weightsList,
      timeDatesList: timeList,
      averageRX: averageWeightMonth,
    );
    getFourteenDaysAverage(
      valuesList: weightsList,
      listOfDates: timeList,
      averageRx: averageWeightFourteenDays,
    );
    getAllDaysAverage(
      averageRx: averageWeightAllDays,
      listOfDates: timeList,
      valuesList: weightsList,
    );
    updateWeightChartList();
  }

  @override
  void onReady() {
    print("===> Widget with weightController was rendered");
    super.onReady();
  }

  void updateWeightChartList() {
    weightsChartList.clear();

    DateTime date = DateTime.now();

    for (int i = 0; i < weightsList.length; i++) {
      // if (weightsList.length <= 3) {
      //   date = DateFormat("dd.MM.yyyy").format(timeList[i]).toString();
      // } else if (weightsList.length > 3 && weightsList.length <= 5) {
      // date = DateFormat("dd.MM.yyyy").format(timeList[i]).substring(0, 5);
      date = timeList[i];
      // } else {
      //   date = DateFormat("dd.MM.yyyy").format(timeList[i]).substring(0, 1);
      // }

      // if (weightsList.length >= 7) {
      //   date =
      //       date = DateFormat("dd.MM.yyyy").format(timeList[i]).substring(0, 1);
      // }

      weightsChartList.add(WeightChart(dateTime: date, weight: weightsList[i]));
    }

    print("___________________");
    weightsChartList.forEach((element) {
      print(element.dateTime.toString() + " // " + element.weight.toString());
    });
    print("___________________");
    update();
  }
}
