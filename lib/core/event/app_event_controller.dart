import 'dart:async';
import 'package:ui_event_bus/core/event/app_event_state.dart';

final AppEventController appEventController = AppEventController();

// 앱 이벤트를 전역적으로 관리합니다.
class AppEventController {
  // 1) 브로드캐스트 Stream
  final _controller = StreamController<AppEventState>.broadcast();
  Stream<AppEventState> get stream => _controller.stream;

  // 2) 이벤트 추가
  void add(AppEventState event) => _controller.add(event);

  static final AppEventController instance = AppEventController._internal();

  factory AppEventController() => instance;
  AppEventController._internal();
}
