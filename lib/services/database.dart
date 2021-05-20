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
          print(
              "|Database|getFirstMeetingFlag\t isFirstMeetingModel is null. Returning true");

          return true;
        } else {
          print(
              "|Database|getFirstMeetingFlag\t  isFirstMeetingModel is not null. returning {${model.isFirstMeetingFlag}} from Hive Flag Model");
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
    print("Getting key = $keyDate, new value = $value");
    weightModel.weightMap[keyDate] = value;
    weightModel.save();
  }

  Future<void> updateWaiste(double value, DateTime keyDate) async {
    final box = await openBox("Waiste");
    WaisteModel waisteModel = box.getAt(0);
    print("Getting key = $keyDate, new value = $value");
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
        print("deleting value of weight = $value");
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
        print("|Database|getWeights\t add weight to list: $value");
      });
      print(
          "|Database|getWeights\t transporting weight list to WeightProv: [$list]");

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
        print("|Database|getWeights\t add time weight to list: $key");
      });
      print(
          "|Database|getWeights\t transporting time weight list to WeightProv: [$list]");

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
        print("|Database|addWeight\t adding weight....");

        model.addWeight(value);
        model.save();
        print(
            "|Database|addWeight\t list of weights after adding value: {${model.weightMap.values}}");
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
        print("|Database|getWaistes\t add waiste to list: $value");
      });
      print(
          "|Database|getWaistes\t transporting waiste list to WeightProv: [$list]");

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
        print("|Database|getTimeWaistes\t add time waiste to list: $key");
      });
      print(
          "|Database|getTimeWaistes\t transporting time waiste list to WeightProv: [$list]");

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
      print(
          "|Database|getWantedWaiste\t error in getting WantedWaiste to Hive box, text of error : $e");
      return 0;
    }
  }

  Future<void> addWaiste(double value) async {
    final box = await openBox("Waiste");
    try {
      WaisteModel model = box.getAt(0);
      if (model == null) {
        print("|Database|addWaiste\t model = null");
      } else {
        model.addWaiste(value);
        model.save();
        print(
            "|Database|addWaiste\t list of waistes after adding value: {${model.waisteMap.values}}");
      }
    } catch (e) {
      print("|Database|addWaiste\t error when adding Waiste: $e");
    }
  }

  Future<void> calculateWantedWaiste(double value) async {
    final box = await openBox("Waiste");
    try {
      WaisteModel model = box.getAt(0);
      if (model == null) {
        print("|Database|calculateWantedWaiste\t model = null");
      } else {
        model.addWantedWaiste(0.49 * value);
        model.setHeight(value);
        model.save();
        print(
            "|Database|addWaiste\t list of waistes after adding value: {${model.waisteMap.values}}");
      }
    } catch (e) {
      print("|Database|calculateWantedWaiste\t error : $e");
    }
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
