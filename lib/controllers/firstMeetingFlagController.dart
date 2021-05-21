import 'package:ctrl_weight/services/database.dart';
import 'package:get/get.dart';

class FirstMeetingFlagController extends GetxController {
  final database = Database();

  bool flag = true;

  Future<bool> getFlagFromHive() async {
    var r = await database.getIsFirstMeetingFlag();
    if (r == null) {
      flag = true;
      update();
    } else {
      flag = r;
      update();
    }
    return flag;
  }

  Future<void> changeFlagInHive() async {
    await database.changeFirstMeetingFlagToFalse();
  }
}
