import 'package:ctrl_weight/intro_screens/intro_screen.dart';
import 'package:ctrl_weight/provider_models/firstflagmeeting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final firstMeetingFlag = watch(isFirstFlagMeetingProvider).getFlag();
    final futureFlag = watch(futureGetFlagProvider);


    return Scaffold(

      appBar: AppBar(),
      body: Center(
        child: futureFlag.map(
          data: (data) => data.value ? IntroScreen() : Text("FALSE. Dashboard"),
          loading: (_) => CircularProgressIndicator(),
          error: (message) => Text(message.error),
        ),
      ),
    );
  }
}
