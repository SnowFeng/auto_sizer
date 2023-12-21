import 'dart:ui';

import 'package:flutter/material.dart';

import 'auto_sizer_platform_dispatcher.dart';
import 'auto_sizer_util.dart';

bool _isInitialized = false;

void runAutoApp(Widget app,
    {required Size designSize, SizerMode mode = SizerMode.portrait}) {
  AutoSizerUtil.instance.init(designSize, mode: mode);
  final WidgetsBinding binding = AutoSizerWidgetsBinding.ensureInitialized();
  assert(binding.debugCheckZone('runApp'));
  binding
    ..scheduleAttachRootWidget(binding.wrapWithDefaultView(app))
    ..scheduleWarmUpFrame();
}

class AutoSizerWidgetsBinding extends WidgetsFlutterBinding {
  static WidgetsBinding ensureInitialized() {
    if (!_isInitialized) {
      AutoSizerWidgetsBinding();
      _isInitialized = true;
    }
    return WidgetsBinding.instance;
  }

  @override
  AutoSizerPlatformDispatcher get platformDispatcher =>
      AutoSizerPlatformDispatcher.instance;
}
