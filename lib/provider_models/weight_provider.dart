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
}

final weightProvider = Provider<WeightDataForProvider>((ref)=>WeightDataForProvider());

