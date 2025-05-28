import 'package:flutter/material.dart';
import 'package:ui_event_bus/core/event/app_event_controller.dart';
import 'package:ui_event_bus/core/event/app_event_state.dart';
import 'package:ui_event_bus/core/navigate_method/navigate_method.dart';

class EventHelpers {
  // 스낵바 띄우기
  static void showSnackBar(String message) {
    appEventController.add(AppEventState.eventSnackBar(message));
  }

  // 라우트 네비게이션
  static void navigate({
    required Widget page,
    NavigationMethod navigateMethod = NavigationMethod.go,
  }) {
    appEventController.add(AppEventState.eventNavigate(
      page: page,
      navigateMethod: navigateMethod,
    ));
  }

  // 라우트 네비게이션
  static void pop({
    dynamic extra,
  }) {
    appEventController.add(AppEventState.eventPop(
      extra,
    ));
  }

  // 다이얼로그 띄우기
  static void showDialog({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) {
    appEventController.add(AppEventState.eventDialog(
      builder: builder,
      barrierDismissible: barrierDismissible,
    ));
  }

  // 다이나믹한 타입 이벤트 처리
  static void eventCustom() {
    appEventController.add(const AppEventState.eventCustom());
  }
}
