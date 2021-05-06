import 'package:ctrl_weight/controllers/firstMeetingFlagController.dart';
import 'package:ctrl_weight/controllers/waisteController.dart';
import 'package:ctrl_weight/controllers/weightsController.dart';
import 'package:ctrl_weight/hive_models/models.dart';
import 'package:ctrl_weight/lading_page.dart';
import 'package:ctrl_weight/screens/dashboard/dashboard.dart';
import 'package:ctrl_weight/screens/intro_screens/intro_screen.dart';
import 'package:ctrl_weight/screens/weights/weights-page.dart';
import 'package:ctrl_weight/start_values_screen/start_values_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(WeightModelAdapter());
  Hive.registerAdapter(WaisteModelAdapter());
  Hive.registerAdapter(IsFirstMeetingFlaggingAdapter());

  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(FirstMeetingFlagController(), permanent: true);
    Get.put(WeightsController(), permanent: true);
    Get.put(WaisteController(), permanent: true);

    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => LandingPage(),
        ),
        GetPage(
          name: "/weights_screen",
          transition: Transition.fade,
          page: () => WeightsPage(),
        ),
        GetPage(
          name: "/intro_screen",
          page: () => IntroScreen(),
        ),
        GetPage(
          name: "/start_values_screen",
          page: () => StartValuesScreen(),
          transition: Transition.zoom,
        ),
        GetPage(
          name: "/dashboard_screen",
          page: () => DashboardScreen(),
          transition: Transition.fade,
        ),
      ],
      // '/': (context) => LandingPage(),
      // '/intro_screen': (context) => IntroScreen(),
      // '/start_values_screen': (context) => StartValuesScreen(),
      // '/dashboard_screen': (context) => DashboardScreen(),

      title: 'Ctrl+Weight',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.playTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
      ),
    );
  }
}
