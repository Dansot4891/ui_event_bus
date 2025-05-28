import 'package:flutter/material.dart';

final _appEventKeyController = AppEventKeyController();

final eventScaffoldKey = _appEventKeyController.scaffoldKey;
final eventNavigateKey = _appEventKeyController.navigateKey;

class AppEventKeyController {
  static final AppEventKeyController instance =
      AppEventKeyController._internal();

  factory AppEventKeyController() => instance;
  AppEventKeyController._internal();

  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final navigateKey = GlobalKey<NavigatorState>();
}
