import 'package:ctrl_weight/hive_models/models.dart';
import 'package:hive/hive.dart';

class Database {
  Future<Box> openBox(String name) async {
    var box = await Hive.openBox(name);
    return box;
  }

  //region >> FirstMeetingFlag
  Future<bool> getIsFirstMeetingFlag() async {
    final box = await openBox("IsFirstMeetingFlag");
    try {
      if (box.isNotEmpty) {
        var model = box.getAt(0);
        if (model == null) {
          print("|Database|\t isFirstMeetingModel is null. Returning true");
          return true;
        } else {
          print(
              "|Database|\t isFirstMeetingModel is not null. returning ${model.isFirstMeetingFlag} from Hive Flag Model");
          return model.isFirstMeetingFlag;
        }
        // if (isFistMeetingModel == null) {
        //   print("|Database|\t isFirstMeetingModel is null. Returning true");
        //   return true;
        // } else {
        //   print(
        //       "|Database|\t isFirstMeetingModel is not null : ${isFistMeetingModel.isFirstMeetingFlag}, returning it");
        //   return isFistMeetingModel.isFirstMeetingFlag;
        return false;
        // }
      } else {
        print("|Database|\t box with isFirstFlag is empty ");
        // create and save in box
        var model = IsFirstMeetingFlagging();
        model.isFirstMeetingFlag = false;
        print("${model.isFirstMeetingFlag.toString()}");
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

// Future<void> setIsFirstMeetingFlagToFalse() async {
//   final box = await openBox("IsFirstMeetingFlag");
//   try {
//     isFistMeetingModel = box.getAt(0);
//     isFistMeetingModel.isFirstMeetingFlag = false;
//     isFistMeetingModel.save();
//     print(
//         "|Database|\t isFirstMeetingFlag set as false due to not first meeting");
//   } catch (e) {
//     print(
//         "|Database|\t error in setting IsFirstMeetingFlag into Hive, text of error : $e");
//
//     isFistMeetingModel.isFirstMeetingFlag = false;
//     isFistMeetingModel.save();
//     box.add(isFistMeetingModel);
//   }
// }
//endregion

}
