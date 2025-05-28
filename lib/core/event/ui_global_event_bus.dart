import 'package:flutter/material.dart';
import 'package:ui_event_bus/core/event/app_event_controller.dart';
import 'package:ui_event_bus/core/event/app_event_state.dart';
import 'package:ui_event_bus/core/key/app_event_key_controller.dart';
import 'package:ui_event_bus/core/navigate_method/navigate_method.dart';

class UIGlobalEventBus extends StatefulWidget {
  final MaterialApp materialApp;
  final void Function(BuildContext)? customEvent;
  const UIGlobalEventBus(this.materialApp, {this.customEvent, super.key});

  @override
  State<UIGlobalEventBus> createState() => _UIGlobalEventBusState();
}

class _UIGlobalEventBusState extends State<UIGlobalEventBus> {
  @override
  void initState() {
    super.initState();
    print('widget.customEvent: ${widget.customEvent}');
    appEventController.stream.listen((event) {
      switch (event) {
        // 네비게이션
        case EventNavigate():
          if (eventNavigateKey.currentContext == null) {
            return;
          }
          switch (event.navigateMethod) {
            case NavigationMethod.push:
              Navigator.of(eventNavigateKey.currentContext!).push(
                MaterialPageRoute(
                  builder: (_) => event.page,
                ),
              );
            case NavigationMethod.go:
              Navigator.of(eventNavigateKey.currentContext!).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => event.page,
                ),
              );
          }
          break;
        // 다이아로그
        case EventDialog():
          if (eventNavigateKey.currentContext == null) {
            return;
          }
          showDialog(
            context: eventNavigateKey.currentContext!,
            barrierDismissible: event.barrierDismissible,
            builder: event.builder,
          );
          break;
        // 스낵바
        case EventSnackBar():
          eventScaffoldKey.currentState?.showSnackBar(
            SnackBar(content: Text(event.message)),
          );
          break;
        // 사용자 커스텀 설정 이벤트
        case EventCustom():
          widget.customEvent != null
              ? widget.customEvent!(eventNavigateKey.currentContext!)
              : () {};
        case EventPop():
          Navigator.of(eventNavigateKey.currentContext!).pop(event.extra);
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.materialApp;
}
