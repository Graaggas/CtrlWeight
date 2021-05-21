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
  }

  Future<bool> getIsFirstMeetingFlag() async {
    final box = await openBox("IsFirstMeetingFlag");
    try {
      if (box.isNotEmpty) {
        var model = box.getAt(0);
        if (model == null) {
          return true;
        } else {
          return model.isFirstMeetingFlag;
        }
      } else {
        // create and save in box
        var model = IsFirstMeetingFlagging();
        model.isFirstMeetingFlag = true;
        box.add(model);

        WeightModel modelWeight = WeightModel();
        // modelWeight.addWeight(0);
        final boxWeight = await openBox("Weight");
        boxWeight.add(modelWeight);

        final boxWaiste = await openBox("Waiste");
        WaisteModel waisteModel = WaisteModel();
        // waisteModel.addWaiste(0);
        boxWaiste.add(waisteModel);

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

  Future<void> updateWeight(double value, DateTime keyDate) async {
    final box = await openBox("Weight");
    WeightModel weightModel = box.getAt(0);
    weightModel.weightMap[keyDate] = value;
    weightModel.save();
  }

  Future<void> updateWaiste(double value, DateTime keyDate) async {
    final box = await openBox("Waiste");
    WaisteModel waisteModel = box.getAt(0);
    waisteModel.waisteMap[keyDate] = value;
    waisteModel.save();
  }

  Future<void> deleteWeight(int index) async {
    final box = await openBox("Weight");
    WeightModel weightModel = box.getAt(0);
    int i = 0;
    DateTime keyToDelete;
    weightModel.weightMap.forEach((key, value) {
      if (i == index) {
        i++;
        keyToDelete = key;
      } else {
        i++;
      }
    });
    if (keyToDelete != null) {
      weightModel.weightMap.remove(keyToDelete);
      weightModel.save();
    }
  }

  Future<void> deleteWaiste(int index) async {
    final box = await openBox("Waiste");
    WaisteModel waisteModel = box.getAt(0);
    int i = 0;
    DateTime keyToDelete;
    waisteModel.waisteMap.forEach((key, value) {
      if (i == index) {
        keyToDelete = key;
      } else {
        i++;
      }
    });
    if (keyToDelete != null) {
      waisteModel.waisteMap.remove(keyToDelete);
      waisteModel.save();
    }
  }

  Future<List<double>> getWeights() async {
    final box = await openBox("Weight");
    try {
      List<double> list = [];
      WeightModel model = box.getAt(0);
      model.weightMap.forEach((key, value) {
        list.add(value);
      });

      return list;
    } catch (e) {
      print("|Database|getWeights\t error in getting weights, error : $e");
      return [];
    }
  }

  Future<List<DateTime>> getTimeWeights() async {
    final box = await openBox("Weight");
    try {
      List<DateTime> list = [];
      WeightModel model = box.getAt(0);
      model.weightMap.forEach((key, value) {
        list.add(key);
      });

      return list;
    } catch (e) {
      print("|Database|getWeights\t error in getting weights, error : $e");
      return [];
    }
  }

  Future<double> getWantedWeight() async {
    final box = await openBox("Weight");
    try {
      double r = 0;
      WeightModel model = box.getAt(0);
      r = model.wantedWeight;
      return r;
    } catch (e) {
      print(
          "|Database|getWantedWeight\t error in getting WantedWeight to Hive box, text of error : $e");
      return 0;
    }
  }

  Future<void> saveWantedWeight(double value) async {
    final box = await openBox("Weight");
    try {
      if (box.isNotEmpty) {
        WeightModel model = box.getAt(0);

        if (model == null) {
          return true;
        } else {
          model.addWantedWeight(value);
          model.save();
        }
      } else {
        // create and save in box
        var model = WeightModel();
        model.addWantedWeight(value);
        box.add(model);
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
      } else {
        model.addWeight(value);
        model.save();
      }
    } catch (e) {
      print("|Database|addWeight\t error when adding Weight: $e");
    }
  }

//endregion

  // region  >> Waiste

  Future<List<double>> getWaistes() async {
    final box = await openBox("Waiste");
    try {
      List<double> list = [];
      WaisteModel model = box.getAt(0);
      model.waisteMap.forEach((key, value) {
        list.add(value);
      });

      return list;
    } catch (e) {
      print("|Database|getWaistes\t error in getting waiste, error : $e");
      return [];
    }
  }

  Future<List<DateTime>> getTimeWaistes() async {
    final box = await openBox("Waiste");
    try {
      List<DateTime> list = [];
      WaisteModel model = box.getAt(0);
      model.waisteMap.forEach((key, value) {
        list.add(key);
      });

      return list;
    } catch (e) {
      print("|Database|getWaistes\t error in getting waistes, error : $e");
      return [];
    }
  }

  Future<double> getWantedWaiste() async {
    final box = await openBox("Waiste");
    try {
      double r = 0;
      WaisteModel model = box.getAt(0);
      r = model.wantedWaiste;
      return r;
    } catch (e) {
      return 0;
    }
  }

  Future<void> addWaiste(double value) async {
    final box = await openBox("Waiste");
    try {
      WaisteModel model = box.getAt(0);
      if (model == null) {
      } else {
        model.addWaiste(value);
        model.save();
      }
    } catch (e) {}
  }

  Future<void> calculateWantedWaiste(double value) async {
    final box = await openBox("Waiste");
    try {
      WaisteModel model = box.getAt(0);
      if (model == null) {
      } else {
        model.addWantedWaiste(0.49 * value);
        model.setHeight(value);
        model.save();
      }
    } catch (e) {}
  }

  Future<double> getHeightFromHive() async {
    final box = await openBox("Waiste");
    try {
      WaisteModel model = box.getAt(0);
      return model.height;
    } catch (e) {
      print(e);
      return null;
    }
  }
//endregion
}
