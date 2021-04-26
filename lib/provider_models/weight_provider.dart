import 'package:ctrl_weight/hive_models/models.dart';
import 'package:ctrl_weight/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final database = Database();

class WeightDataForProvider {
  static final WeightDataForProvider _instance =
      WeightDataForProvider._internal();

  WeightDataForProvider._internal() {}

  factory WeightDataForProvider() {
    return _instance;
  }

  Future<void> saveWantedWeight(double value) async {
    return database.saveWantedWeight(value);
  }

  Future<void> addWeight(double value) async {
    return database.addWeight(value);
  }

  Future<double> getCurrentWeight() async {
    return database.getCurrentWeight();
  }
}

final weightProvider =
    Provider<WeightDataForProvider>((ref) => WeightDataForProvider());

final futureCurrentWeightProvider = FutureProvider<double>((ref) async {
  final f = ref.read(weightProvider);
  return f.getCurrentWeight();
});
