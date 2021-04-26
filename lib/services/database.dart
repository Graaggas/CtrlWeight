import 'package:ctrl_weight/hive_models/models.dart';
import 'package:hive/hive.dart';

class Database {
  Future<Box> openBox(String name) async {
    var box = await Hive.openBox(name);
    return box;
  }

  //region >> FirstMeetingFlag
  Future<void> changeFirstMeetingFlagToFalse() async {
    final box = await openBox("IsFirstMeetingFlag");
    var model = box.getAt(0);
    model.isFirstMeetingFlag = false;
    model.save();
    print(
        "|Database|\t isFirstMeetingFlag changed to {${model.isFirstMeetingFlag.toString()}}");
  }

  Future<bool> getIsFirstMeetingFlag() async {
    final box = await openBox("IsFirstMeetingFlag");
    try {
      if (box.isNotEmpty) {
        var model = box.getAt(0);
        if (model == null) {
          print("|Database|\t isFirstMeetingModel is null. Returning true");
          WeightModel modelWeight = WeightModel();
          modelWeight.addWeight(0);
          box.add(modelWeight);

          return true;
        } else {
          print(
              "|Database|\t isFirstMeetingModel is not null. returning {${model.isFirstMeetingFlag}} from Hive Flag Model");
          return model.isFirstMeetingFlag;
        }
      } else {
        print("|Database|\t box with isFirstFlag is empty ");
        // create and save in box
        var model = IsFirstMeetingFlagging();
        model.isFirstMeetingFlag = true;
        box.add(model);
        // model = box.getAt(0);
        // print("${model.isFirstMeetingFlag.toString()}");

        return true;
      }
    } catch (e) {
      print(
          "|Database|\t error in opening IsFirstMeetingFlag from Hive, text of error : $e");

      return true;
    }
  }

//endregion

  // region >> Weight
  Future<void> saveWantedWeight(double value) async {
    final box = await openBox("Weight");
    try {
      if (box.isNotEmpty) {
        WeightModel model = box.getAt(0);

        if (model == null) {
          print("|Database|\t Weight is null");
          return true;
        } else {
          print(
              "|Database|\t Weight is not null. old wanted Weight is {${model.wantedWeight.toString()}}");

          model.addWantedWeight(value);
          model.save();
          print(
              "|Database|\t Weight is not null. saving wanted Weight as {$value}");
        }
      } else {
        print("|Database|\t box with Weights is empty ");
        // create and save in box
        var model = WeightModel();
        model.addWantedWeight(value);
        box.add(model);
        print(
            "|Database|\t Weight is not null. saving wanted Weight as {$value}");
      }
    } catch (e) {
      print(
          "|Database|\t error in saving WantedWeight to Hive box, text of error : $e");
    }
  }

  Future<void> addWeight(double value) async {
    final box = await openBox("Weight");
    try {
      WeightModel model = box.getAt(0);
      if (model == null) {
        print("|Database|addWeight\t model = null");
      } else {
        print("adding weight....");
      }
    } catch (e) {
      print("|Database|addWeight\t error when adding Weight: $e");
    }
  }

  Future<double> getCurrentWeight() async {
    final box = await openBox("Weight");
    try {
      WeightModel model = box.getAt(0);
      if (model == null) {
        print("|Database|getCurrentWeight\t model = null");
      } else {
        List<double> list = [];
        for (var item in model.weightMap.entries) {
          list.add(item.value);
        }
        print(
            "|Database|getCurrentWeight\t current Weight = ${list.last.toString()}");
        return list.last;
      }
    } catch (e) {
      print("|Database|getCurrentWeight\t error when adding Weight: $e");
      return 0;
    }
    return -2;
  }
//endregion

//region Waiste
  Future<void> addWaiste(double value) async {
    final box = await openBox("Waiste");
    try {
      WeightModel model = box.getAt(0);
      if (model == null) {
        print("|Database|addWaiste\t model = null");
      } else {
        print("adding waiste....");
      }
    } catch (e) {
      print("|Database|addWaiste\t error when adding Waiste: $e");
    }
  }

  Future<double> getCurrentWaiste() async {
    final box = await openBox("Waiste");
    try {
      WaisteModel model = box.getAt(0);
      if (model == null) {
        print("|Database|getCurrentWaiste\t model = null");
      } else {
        List<double> list = [];
        for (var item in model.waisteMap.entries) {
          list.add(item.value);
        }
        print(
            "|Database|getCurrentWaiste\t current Weight = ${list.last.toString()}");
        return list.last;
      }
    } catch (e) {
      print("|Database|getCurrentWaiste\t error when adding Waiste: $e");
      return 0;
    }
    return -2;
  }
//endregion
}
