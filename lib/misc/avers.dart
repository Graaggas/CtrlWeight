import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

Future<void> getFourteenDaysAverage(
    {RxList<DateTime> listOfDates,
    RxList<double> valuesList,
    RxDouble averageRx}) async {
  try {
    double average7days = 0.0;
    double diff = 0.0;

    var cuDay = listOfDates[listOfDates.length - 1];
    var currentDay = Jiffy(cuDay);

    var now = Jiffy(DateTime.now());
    var firstOfFourteenDay = now.subtract(days: 14);
    List<double> list = [];
    for (int i = 0; i < listOfDates.length; i++) {
      var r = Jiffy(listOfDates[i]);

      if (r.isBetween(firstOfFourteenDay, currentDay.add(days: 1))) {
        list.add(valuesList[i]);
      }
    }

    for (int i = 1; i < list.length; i++) {
      diff = list[i] - list[i - 1];
      average7days = average7days + diff;
    }

    averageRx.value = average7days;
  } catch (e) {
    print("no data, e:$e");
  }

  // update();
}

Future<void> getAllDaysAverage(
    {RxList<DateTime> listOfDates,
    RxList<double> valuesList,
    RxDouble averageRx}) async {
  try {
    double average = 0.0;
    double diff = 0.0;

    for (int i = 0; i < valuesList.length; i++) {
      if (i == 0) {
      } else {
        diff = valuesList[i] - valuesList[i - 1];
        average = average + diff;
      }
    }

    averageRx.value = average;
  } catch (e) {
    print("no data, error: $e");
  }

  // update();
}

Future<void> getSevenDaysAverage(
    {RxList<DateTime> timeDateList,
    RxList<double> valuesList,
    RxDouble averageRx}) async {
  try {
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
    // update();
  } catch (e) {
    print("no data, error: $e");
  }
}

Future<void> getMonthsAverage(
    {RxList<DateTime> timeDatesList,
    RxList<double> valuesList,
    RxDouble averageRX}) async {
  try {
    double averageMonth = 0.0;
    double diff = 0.0;

    var cuDay = timeDatesList[timeDatesList.length - 1];
    var currentDay = Jiffy(cuDay);
    // logger.info("current day", currentDay.format("dd MMMM yyyy, hh:mm:ss"),
    //     StackTrace.current);
    var now = Jiffy(DateTime.now());
    var firstOfMonth = now.subtract(days: 31);
    List<double> list = [];
    for (int i = 0; i < timeDatesList.length; i++) {
      var r = Jiffy(timeDatesList[i]);

      // print(r.format("dd MMMM yyyy, hh:mm:ss"));
      if (r.isBetween(firstOfMonth, currentDay.add(days: 1))) {
        // print("==> ${r.format("dd MMMM yyyy, hh:mm:ss")}");
        list.add(valuesList[i]);
      }

      // print("==> 14 => ${averageWeightFourteenDays.value}");
    }

    // print("aver start = $averageMonth");
    for (int i = 1; i < list.length; i++) {
      diff = list[i] - list[i - 1];
      // print("${list[i]}-${list[i - 1]}");
      averageMonth = averageMonth + diff;
      // print("aver = $averageMonth");
    }
    //
    // logger.info("14 days diff", averageMonth, StackTrace.current);
    averageRX.value = averageMonth;
  } catch (e) {
    print("no data, error: $e");
  }
}
