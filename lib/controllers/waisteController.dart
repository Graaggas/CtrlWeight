import 'package:ctrl_weight/services/database.dart';
import 'package:get/get.dart';

class WaisteController extends GetxController {
  final database = Database();

  var waisteList = <double>[].obs;

  var timeList = <DateTime>[].obs;

  var wantedWaiste = 0.0.obs;

  var height = 0.0.obs;

  var currentWaiste = 0.0.obs;

  var startWaiste = 0.0.obs;

  Future<void> addWaiste(double value) async {
    await database.addWaiste(value);
    if(waisteList.isEmpty){
      startWaiste.value = value;
      wantedWaiste.value = 0.49*height.value;
      calculateWantedWaiste(height.value);
    }
    waisteList.add(value);
    timeList.add(DateTime.now());
    currentWaiste.value = value;

    update();
  }

  Future<void> calculateWantedWaiste(double value) async {
    await database.calculateWantedWaiste(value);
    wantedWaiste.value = 0.49*value;
    print("|WeightController|saveWantedWeight\t wantedWeight = $wantedWaiste");
  }

  @override
  void onInit() async {
    print("===> try to init waisteController");
    wantedWaiste.value = await database.getWantedWaiste();
    print("|WeightController|onInit: wantedWaiste = ${wantedWaiste.value}");

    waisteList.value = await database.getWaistes();
    print("|WeightController|onInit: waistesList = ${waisteList.value}");

    timeList.value = await database.getTimeWaistes();
    print("|WeightController|onInit: timeList = ${timeList.value}");

    var r = await database.getWaistes();
    if (r.isNotEmpty) {
      startWaiste.value = r.first;
      print("|WeightController|onInit: startWeight = ${startWaiste.value}");
      currentWaiste.value = r.last;
      print("|WeightController|onInit: currentWeight = ${currentWaiste.value}");
    }

    super.onInit();
  }

  @override
  void onReady() {
    print("===> Widget with waisteController was rendered");
    super.onReady();
  }

}
//TODO не работает конечный замер окружности