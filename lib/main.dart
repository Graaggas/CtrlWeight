import 'package:ctrl_weight/dashboard/dashboard.dart';
import 'package:ctrl_weight/hive_models/models.dart';
import 'package:ctrl_weight/intro_screens/intro_screen.dart';
import 'package:ctrl_weight/lading_page.dart';
import 'package:ctrl_weight/start_values_screen/start_values_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/': (context) => LandingPage(),
        '/intro_screen': (context) => IntroScreen(),
        '/start_values_screen': (context) => StartValuesScreen(),
        '/dashboard_screen': (context) => DashboardScreen(),
      },
      title: 'Ctrl+Weight',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.playTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
      ),
    );
  }
}
