import 'package:flutter/material.dart';
import 'package:ui_event_bus/core/event/app_event_controller.dart';
import 'package:ui_event_bus/core/event/app_event_state.dart';
import 'package:ui_event_bus/core/key/app_event_key_controller.dart';
import 'package:ui_event_bus/core/navigate_method/navigate_method.dart';

class AppGlobalEventBus extends StatefulWidget {
  final MaterialApp materialApp;
  final dynamic dynamicEvent;
  const AppGlobalEventBus(this.materialApp, {this.dynamicEvent, super.key});

  @override
  State<AppGlobalEventBus> createState() => _AppGlobalEventBusState();
}

class _AppGlobalEventBusState extends State<AppGlobalEventBus> {
  final AppEventKeyController _appEventKey = AppEventKeyController();
  @override
  void initState() {
    super.initState();
    appEventController.stream.listen((event) {
      switch (event) {
        // 네비게이션
        case EventNavigate():
          if (_appEventKey.navigateKey.currentContext == null) {
            return;
          }
          switch (event.navigateMethod) {
            case NavigationMethod.push:
              Navigator.of(_appEventKey.navigateKey.currentContext!).push(
                MaterialPageRoute(
                  builder: (_) => event.builder,
                ),
              );
            case NavigationMethod.go:
              Navigator.of(_appEventKey.navigateKey.currentContext!)
                  .pushReplacement(
                MaterialPageRoute(
                  builder: (_) => event.builder,
                ),
              );
          }
          break;
        // 다이아로그
        case EventDialog():
          if (_appEventKey.navigateKey.currentContext == null) {
            return;
          }
          showDialog(
            context: _appEventKey.navigateKey.currentContext!,
            barrierDismissible: event.barrierDismissible,
            builder: event.builder,
          );
          break;
        // 스낵바
        case EventSnackBar():
          _appEventKey.scaffoldKey.currentState?.showSnackBar(
            SnackBar(content: Text(event.message)),
          );
          break;
        // 사용자 커스텀 설정 이벤트
        case EventDynamic():
          widget.dynamicEvent;
        case EventPop():
          Navigator.of(_appEventKey.navigateKey.currentContext!)
              .pop(event.extra);
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.materialApp;
}
