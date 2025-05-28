import 'package:flutter/material.dart';
import 'package:ui_event_bus/ui_event_bus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UIGlobalEventBus(
      MaterialApp(
        home: const EventEx1(),
        scaffoldMessengerKey: eventScaffoldKey,
        navigatorKey: eventNavigateKey,
      ),
      customEvent: (BuildContext ctx) {
        print('object');
      },
    );
  }
}

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
            TextButton(
                onPressed: () {
                  EventHelpers.dynamicType();
                },
                child: const Text('dynamic')),
          ],
        ),
      ),
    );
  }
}

class EventEx2 extends StatelessWidget {
  const EventEx2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            EventHelpers.pop();
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ex2'),
          ],
        ),
      ),
    );
  }
}
