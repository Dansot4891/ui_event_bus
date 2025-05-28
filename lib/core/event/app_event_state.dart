import 'package:flutter/material.dart';
import 'package:ui_event_bus/core/navigate_method/navigate_method.dart';

sealed class AppEventState {
  const factory AppEventState.eventNavigate({
    required Widget builder,
    required dynamic extra,
    required NavigationMethod navigateMethod,
  }) = EventNavigate;

  const factory AppEventState.eventPop(dynamic extra) = EventPop;

  const factory AppEventState.eventDialog({
    required Widget Function(BuildContext) builder,
    required bool barrierDismissible,
  }) = EventDialog;

  const factory AppEventState.eventSnackBar(String e) = EventSnackBar;

  const factory AppEventState.eventDynamic() = EventDynamic;
}

class EventNavigate implements AppEventState {
  final Widget builder;
  final dynamic extra;
  final NavigationMethod navigateMethod;

  const EventNavigate({
    required this.builder,
    this.extra,
    required this.navigateMethod,
  });
}

class EventPop implements AppEventState {
  final dynamic extra;

  const EventPop(this.extra);
}

class EventDialog implements AppEventState {
  final Widget Function(BuildContext) builder;
  final bool barrierDismissible;

  const EventDialog({
    required this.builder,
    this.barrierDismissible = true,
  });
}

class EventSnackBar implements AppEventState {
  final String message;

  const EventSnackBar(this.message);
}

class EventDynamic implements AppEventState {
  const EventDynamic();
}
