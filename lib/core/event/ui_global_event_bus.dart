import 'package:flutter/material.dart';
import 'package:ui_event_bus/core/event/app_event_controller.dart';
import 'package:ui_event_bus/core/event/app_event_state.dart';
import 'package:ui_event_bus/core/key/app_event_key_controller.dart';
import 'package:ui_event_bus/core/navigate_method/navigate_method.dart';

class UIGlobalEventBus extends StatefulWidget {
  final MaterialApp materialApp;
  final void Function(BuildContext)? customEvent;
  final GlobalKey<ScaffoldMessengerState>? scaffoldKey;
  final GlobalKey<NavigatorState>? navigateKey;
  const UIGlobalEventBus(this.materialApp,
      {this.customEvent, this.scaffoldKey, this.navigateKey, super.key});

  @override
  State<UIGlobalEventBus> createState() => _UIGlobalEventBusState();
}

class _UIGlobalEventBusState extends State<UIGlobalEventBus> {
  @override
  void initState() {
    super.initState();
    final scaffoldKey = widget.scaffoldKey ?? eventScaffoldKey;
    final navigateKey = widget.navigateKey ?? eventNavigateKey;
    appEventController.stream.listen((event) {
      switch (event) {
        // 네비게이션
        case EventNavigate():
          if (navigateKey.currentContext == null) {
            return;
          }
          switch (event.navigateMethod) {
            case NavigationMethod.push:
              Navigator.of(navigateKey.currentContext!).push(
                MaterialPageRoute(
                  builder: (_) => event.page,
                ),
              );
            case NavigationMethod.go:
              Navigator.of(navigateKey.currentContext!).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => event.page,
                ),
              );
          }
          break;
        // 다이아로그
        case EventDialog():
          if (navigateKey.currentContext == null) {
            return;
          }
          showDialog(
            context: navigateKey.currentContext!,
            barrierDismissible: event.barrierDismissible,
            builder: event.builder,
          );
          break;
        // 스낵바
        case EventSnackBar():
          scaffoldKey.currentState?.showSnackBar(
            SnackBar(content: Text(event.message)),
          );
          break;
        // 사용자 커스텀 설정 이벤트
        case EventCustom():
          widget.customEvent != null
              ? widget.customEvent!(navigateKey.currentContext!)
              : () {};
        case EventPop():
          Navigator.of(navigateKey.currentContext!).pop(event.extra);
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.materialApp;
}
