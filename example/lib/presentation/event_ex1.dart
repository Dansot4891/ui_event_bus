import 'package:example/presentation/event_ex2.dart';
import 'package:flutter/material.dart';
import 'package:ui_event_bus/ui_event_bus.dart';

class EventEx1 extends StatelessWidget {
  const EventEx1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  EventHelpers.showSnackBar('message');
                },
                child: const Text('snackbar')),
            TextButton(
                onPressed: () {
                  EventHelpers.navigate(
                    builder: const EventEx2(),
                    navigateMethod: NavigationMethod.push,
                  );
                },
                child: const Text('navigate')),
            TextButton(
                onPressed: () {
                  EventHelpers.showDialog(
                    builder: (ctx) => const AlertDialog(
                      title: Text('title'),
                      content: Text('context'),
                    ),
                  );
                },
                child: const Text('dialog')),
            TextButton(onPressed: () {}, child: const Text('dynamic')),
          ],
        ),
      ),
    );
  }
}
