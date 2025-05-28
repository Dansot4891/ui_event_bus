import 'package:flutter/material.dart';
import 'package:ui_event_bus/ui_event_bus.dart';

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
