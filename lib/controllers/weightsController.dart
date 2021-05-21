import 'package:ctrl_weight/misc/avers.dart';
import 'package:ctrl_weight/misc/chart_data.dart';
import 'package:ctrl_weight/services/database.dart';
import 'package:get/get.dart';

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
    averAlldays.value = value;
    update();
  }

  void changeAverMonth(bool value) {
    averMonth.value = value;
    update();
  }

  void changeAverSevenDays(bool value) {
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
    update();
  }

//*+
  Future<void> updateWeight(int index, double value, DateTime date) async {
    await database.updateWeight(value, date);
    if (index == 0) {
      startWeight.value = value;
    }
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
    wantedWeight.value = await database.getWantedWeight();

    weightsList.value = await database.getWeights();

    timeList.value = await database.getTimeWeights();

    var r = await database.getWeights();
    if (r.isNotEmpty) {
      startWeight.value = r.first;
      currentWeight.value = r.last;
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
    super.onReady();
  }

  void updateWeightChartList() {
    weightsChartList.clear();

    DateTime date = DateTime.now();

    for (int i = 0; i < weightsList.length; i++) {
      date = timeList[i];

      weightsChartList.add(WeightChart(dateTime: date, weight: weightsList[i]));
    }

    update();
  }
}
