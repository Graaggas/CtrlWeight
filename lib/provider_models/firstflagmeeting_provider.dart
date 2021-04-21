import 'package:ctrl_weight/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final database = Database();

class IsFirstMeetingFlagModel {
  static final IsFirstMeetingFlagModel _instance =
      IsFirstMeetingFlagModel._internal();

  IsFirstMeetingFlagModel._internal() {}

  factory IsFirstMeetingFlagModel() {
    return _instance;
  }

  void changeFlag() {
    // database.setIsFirstMeetingFlagToFalse();
  }

  Future<bool> getFlagFromHive() {
    return database.getIsFirstMeetingFlag();
  }
}

//? Providers

final getFlagProvider = Provider((ref) => IsFirstMeetingFlagModel());
final futureGetFlagProvider = FutureProvider<bool>((ref) async {
  final f = ref.read(getFlagProvider);
  return f.getFlagFromHive();
});
