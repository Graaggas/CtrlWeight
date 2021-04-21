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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read(getFlagProvider).changeFlag();
        },
      ),
      appBar: AppBar(),
      body: Center(
        child: futureFlag.map(
          data: (data) => data.value ? Text("TRUE") : Text("FALSE"),
          loading: (_) => CircularProgressIndicator(),
          error: (message) => Text(message.error),
        ),
      ),
    );
  }
}
