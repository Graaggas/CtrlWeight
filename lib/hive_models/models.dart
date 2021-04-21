import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 1)
class WeightModel extends HiveObject {
  //* fields

  @HiveField(1)
  Map<DateTime, double> _weightMap = new Map();

  @HiveField(2)
  double _wantedWeight;

  @HiveField(3)
  double _startWeightForCalculating;

  Map<DateTime, double> get weightMap => _weightMap;

  //* getters

  double get wantedWeight => _wantedWeight;

  double get startWeightForCalculating => _startWeightForCalculating;

  //* methods

  void addWeight(double value) {
    DateTime dateTime = DateTime.now();
    _weightMap[dateTime] = value;
  }

  void setStartWeightForCalculating(double value) {
    _startWeightForCalculating = value;
  }

  void addWantedWeight(double value) {
    _wantedWeight = value;
  }
}

@HiveType(typeId: 2)
class WaisteModel extends HiveObject {
  //* fields

  @HiveField(1)
  Map<DateTime, double> _waisteMap = new Map();

  @HiveField(2)
  double _wantedWaiste;

  @HiveField(3)
  double _startWaisteForCalculating;

  Map<DateTime, double> get waisteMap => _waisteMap;

  //* getters

  double get wantedWaiste => _wantedWaiste;

  double get startWaisteForCalculating => _startWaisteForCalculating;

  //* methods

  void addWaiste(double value) {
    DateTime dateTime = DateTime.now();
    _waisteMap[dateTime] = value;
  }

  void setStartWaisteForCalculating(double value) {
    _startWaisteForCalculating = value;
  }

  void addWantedWaiste(double value) {
    _wantedWaiste = value;
  }
}

@HiveType(typeId: 3)
class IsFirstMeetingFlagging extends HiveObject {
  @HiveField(1)
  bool isFirstMeetingFlag;
}
