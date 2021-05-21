import 'package:ctrl_weight/misc/avers.dart';
import 'package:ctrl_weight/misc/chart_data.dart';
import 'package:ctrl_weight/services/database.dart';
import 'package:get/get.dart';

class WaisteController extends GetxController {
  final database = Database();

  var averageWaisteAllDays = 0.0.obs;

  var averageWaisteSevenDays = 0.0.obs;

  var averageWaisteFourteenDays = 0.0.obs;

  var averageWaistetMonth = 0.0.obs;

  var averAlldays = false.obs;
  var averSevenDays = false.obs;
  var averMonth = false.obs;

  var waisteList = <double>[].obs;

  var timeList = <DateTime>[].obs;

  var wantedWaiste = 0.0.obs;

  var height = 0.0.obs;

  var currentWaiste = 0.0.obs;

  var startWaiste = 0.0.obs;

  var diffWaiste = 0.0.obs;

  var waisteChartList = <WaisteChart>[].obs;

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

  void getWaisteDiff() {
    if (waisteList.length == 1) {
      diffWaiste.value = 0.0;
    } else if (waisteList.isNotEmpty) {
      diffWaiste.value =
          currentWaiste.value - waisteList[waisteList.length - 2];
    }
  }

  Future<void> deleteWaiste(int index) async {
    await database.deleteWaiste(index);
    waisteList.removeAt(index);
    timeList.removeAt(index);
    if (waisteList.isNotEmpty) {
      currentWaiste.value = waisteList.last;
    } else {
      currentWaiste.value = 0;
    }

    if (index == 0) {
      if (waisteList.isNotEmpty) {
        startWaiste.value = waisteList.first;
      } else
        startWaiste.value = 0.0;
    }
    update();
    getWaisteDiff();
    getSevenDaysAverage(
      valuesList: waisteList,
      timeDateList: timeList,
      averageRx: averageWaisteSevenDays,
    );
    getMonthsAverage(
      valuesList: waisteList,
      timeDatesList: timeList,
      averageRX: averageWaistetMonth,
    );
    getFourteenDaysAverage(
      valuesList: waisteList,
      listOfDates: timeList,
      averageRx: averageWaisteFourteenDays,
    );
    getAllDaysAverage(
      averageRx: averageWaisteAllDays,
      listOfDates: timeList,
      valuesList: waisteList,
    );
    updateWaisteChartList();
  }

  void updateWaisteChartList() {
    DateTime date = DateTime.now();

    for (int i = 0; i < waisteList.length; i++) {
      date = timeList[i];

      waisteChartList.add(WaisteChart(dateTime: date, waiste: waisteList[i]));
    }

    print("___________waiste chart________");
    waisteChartList.forEach((element) {
      print(element.dateTime.toString() + " // " + element.waiste.toString());
    });
    print("___________________");
    update();
  }

  Future<void> addWaiste(double value) async {
    print("waisteController.\t adding new waiste $value");
    await database.addWaiste(value);
    if (waisteList.isEmpty) {
      startWaiste.value = value;
    }
    waisteList.add(value);
    timeList.add(DateTime.now());
    currentWaiste.value = value;
    update();
    getWaisteDiff();
    getSevenDaysAverage(
      valuesList: waisteList,
      timeDateList: timeList,
      averageRx: averageWaisteSevenDays,
    );
    getMonthsAverage(
      valuesList: waisteList,
      timeDatesList: timeList,
      averageRX: averageWaistetMonth,
    );
    getFourteenDaysAverage(
      valuesList: waisteList,
      listOfDates: timeList,
      averageRx: averageWaisteFourteenDays,
    );
    getAllDaysAverage(
      averageRx: averageWaisteAllDays,
      listOfDates: timeList,
      valuesList: waisteList,
    );
    updateWaisteChartList();
  }

  Future<void> calculateWantedWaiste(double value) async {
    await database.calculateWantedWaiste(value);
    height.value = value;
    wantedWaiste.value = 0.49 * value;

    update();
  }

  Future<void> getHeightFromHive() async {
    var r = await database.getHeightFromHive();
    if (r != null) {
      height.value = r;
    }
  }

  @override
  void onInit() async {
    print("===> try to init waisteController");
    wantedWaiste.value = await database.getWantedWaiste();
    print("|WeightController|onInit: wantedWaiste = ${wantedWaiste.value}");

    waisteList.value = await database.getWaistes();
    print("|WeightController|onInit: waistesList = ;waisteList");

    timeList.value = await database.getTimeWaistes();
    print("|WeightController|onInit: timeList = $timeList");

    var r = await database.getWaistes();
    if (r.isNotEmpty) {
      startWaiste.value = r.first;
      print("|WeightController|onInit: startWeight = ${startWaiste.value}");
      currentWaiste.value = r.last;
      print("|WeightController|onInit: currentWeight = ${currentWaiste.value}");
    }

    super.onInit();
    update();

    getHeightFromHive();
    getWaisteDiff();
    getSevenDaysAverage(
      valuesList: waisteList,
      timeDateList: timeList,
      averageRx: averageWaisteSevenDays,
    );
    getMonthsAverage(
      valuesList: waisteList,
      timeDatesList: timeList,
      averageRX: averageWaistetMonth,
    );
    getFourteenDaysAverage(
      valuesList: waisteList,
      listOfDates: timeList,
      averageRx: averageWaisteFourteenDays,
    );
    getAllDaysAverage(
      averageRx: averageWaisteAllDays,
      listOfDates: timeList,
      valuesList: waisteList,
    );
    updateWaisteChartList();
  }

  @override
  void onReady() {
    print("===> Widget with waisteController was rendered");

    // print('HEIGHT: ${height.value}');
    // wantedWaiste.value = 0.49 * height.value;
    // print('WANTEDWAISTE: ${wantedWaiste.value}');
    super.onReady();
  }

  Future<void> updateWaiste(int index, double value, DateTime date) async {
    await database.updateWaiste(value, date);
    currentWaiste.value = value;
    waisteList[index] = value;

    if (index == 0) {
      startWaiste.value = value;
    }
    update();
    getWaisteDiff();
    getSevenDaysAverage(
      valuesList: waisteList,
      timeDateList: timeList,
      averageRx: averageWaisteSevenDays,
    );
    getMonthsAverage(
      valuesList: waisteList,
      timeDatesList: timeList,
      averageRX: averageWaistetMonth,
    );
    getFourteenDaysAverage(
      valuesList: waisteList,
      listOfDates: timeList,
      averageRx: averageWaisteFourteenDays,
    );
    getAllDaysAverage(
      averageRx: averageWaisteAllDays,
      listOfDates: timeList,
      valuesList: waisteList,
    );
    updateWaisteChartList();
  }
}
