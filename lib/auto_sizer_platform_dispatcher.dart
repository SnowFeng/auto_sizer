import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_sizer/auto_sizer.dart';

import 'auto_sizer_window.dart';

class AutoSizerPlatformDispatcher implements PlatformDispatcher{

  final PlatformDispatcher _platformDispatcher = PlatformDispatcher.instance;

  static AutoSizerPlatformDispatcher get instance => _instance;
  static final AutoSizerPlatformDispatcher _instance = AutoSizerPlatformDispatcher._();

  AutoSizerPlatformDispatcher._(){
    _updateViewsAndDisplays();
    _platformDispatcher.onMetricsChanged = _handleMetricsChanged;
  }

  final Map<int, AutoSizerView> _autoSizerViews = <int, AutoSizerView>{};
  
  final Map<int, AutoSizerDisplay> _autoSizerDisplays = <int, AutoSizerDisplay>{};

  void _handleMetricsChanged() {
    AutoSizer.instance.onMetricsChanged();
    _updateViewsAndDisplays();
    _onMetricsChanged?.call();
  }

  @override
  VoidCallback? get onAccessibilityFeaturesChanged => _platformDispatcher.onAccessibilityFeaturesChanged;

  @override
  set onAccessibilityFeaturesChanged(VoidCallback? callback) {
    _platformDispatcher.onAccessibilityFeaturesChanged = callback;
  }

  @override
  FrameCallback? get onBeginFrame =>_platformDispatcher.onBeginFrame;

  @override
  set onBeginFrame(FrameCallback? callback) {
    _platformDispatcher.onBeginFrame = callback;
  }

  @override
  VoidCallback? get onDrawFrame => _platformDispatcher.onDrawFrame;

  @override
  set onDrawFrame(VoidCallback? callback) {
    _platformDispatcher.onDrawFrame = callback;
  }

  @override
  VoidCallback? get onFrameDataChanged => _platformDispatcher.onFrameDataChanged;
  @override
  set onFrameDataChanged(VoidCallback? value) {
    _platformDispatcher.onFrameDataChanged = value;
  }

  @override
  KeyDataCallback? get onKeyData => _platformDispatcher.onKeyData;

  @override
  set onKeyData(KeyDataCallback? onKeyData) {
    _platformDispatcher.onKeyData = onKeyData;
  }

  @override
  VoidCallback? get onLocaleChanged => _platformDispatcher.onLocaleChanged;
  @override
  set onLocaleChanged(VoidCallback? callback) {
    _platformDispatcher.onLocaleChanged = callback;
  }

  @override
  VoidCallback? get onMetricsChanged => _platformDispatcher.onMetricsChanged;

  VoidCallback? _onMetricsChanged;
  @override
  set onMetricsChanged(VoidCallback? callback) {
    _onMetricsChanged = callback;
  }

  @override
  VoidCallback? get onPlatformBrightnessChanged => _platformDispatcher.onPlatformBrightnessChanged;
  @override
  set onPlatformBrightnessChanged(VoidCallback? callback) {
    _platformDispatcher.onPlatformBrightnessChanged = callback;
  }

  @override
  VoidCallback? get onPlatformConfigurationChanged => _platformDispatcher.onPlatformConfigurationChanged;

  @override
  set onPlatformConfigurationChanged(VoidCallback? onPlatformConfigurationChanged) {
    _platformDispatcher.onPlatformConfigurationChanged = onPlatformConfigurationChanged;
  }

  @override
  PlatformMessageCallback? get onPlatformMessage => _platformDispatcher.onPlatformMessage;
  @Deprecated(
      'Instead of setting this callback, use ServicesBinding.instance.defaultBinaryMessenger.setMessageHandler. '
          'This feature was deprecated after v2.1.0-10.0.pre.'
  )
  @override
  set onPlatformMessage(PlatformMessageCallback? callback) {
    _platformDispatcher.onPlatformMessage = callback;
  }

  @override
  PointerDataPacketCallback? get onPointerDataPacket => _platformDispatcher.onPointerDataPacket;
  @override
  set onPointerDataPacket(PointerDataPacketCallback? callback) {
    _platformDispatcher.onPointerDataPacket = callback;
  }

  @override
  TimingsCallback? get onReportTimings => _platformDispatcher.onReportTimings;
  @override
  set onReportTimings(TimingsCallback? callback) {
    _platformDispatcher.onReportTimings = callback;
  }

  @override
  SemanticsActionEventCallback? get onSemanticsActionEvent => _platformDispatcher.onSemanticsActionEvent;
  @override
  set onSemanticsActionEvent(SemanticsActionEventCallback? callback) {
    _platformDispatcher.onSemanticsActionEvent = callback;
  }

  @override
  VoidCallback? get onSemanticsEnabledChanged => _platformDispatcher.onSemanticsEnabledChanged;
  @override
  set onSemanticsEnabledChanged(VoidCallback? callback) {
    _platformDispatcher.onSemanticsEnabledChanged = callback;
  }

  @override
  VoidCallback? get onSystemFontFamilyChanged => _platformDispatcher.onSystemFontFamilyChanged;
  @override
  set onSystemFontFamilyChanged(VoidCallback? value) {
    _platformDispatcher.onSystemFontFamilyChanged = value;
  }

  @override
  VoidCallback? get onTextScaleFactorChanged => _platformDispatcher.onTextScaleFactorChanged;
  @override
  set onTextScaleFactorChanged(VoidCallback? callback) {
    _platformDispatcher.onTextScaleFactorChanged = callback;
  }

  @override
  ErrorCallback? get onError => _platformDispatcher.onError;

  @override
  set onError(ErrorCallback? value) {
    _platformDispatcher.onError = value;
  }

  @override
  AccessibilityFeatures get accessibilityFeatures => _platformDispatcher.accessibilityFeatures;

  @override
  bool get alwaysUse24HourFormat => _platformDispatcher.alwaysUse24HourFormat;

  @override
  bool get brieflyShowPassword => _platformDispatcher.brieflyShowPassword;

  @override
  Locale? computePlatformResolvedLocale(List<Locale> supportedLocales) {
    return _platformDispatcher.computePlatformResolvedLocale(supportedLocales);
  }

  @override
  String get defaultRouteName => _platformDispatcher.defaultRouteName;

  @override
  Iterable<AutoSizerDisplay> get displays => _autoSizerDisplays.values;

  @override
  FrameData get frameData => _platformDispatcher.frameData;

  @override
  ByteData? getPersistentIsolateData() {
    return _platformDispatcher.getPersistentIsolateData();
  }

  @override
  FlutterView? get implicitView =>  _platformDispatcher.implicitView != null
  ? _autoSizerViews[_platformDispatcher.implicitView!.viewId]!
      : null;

  @override
  String get initialLifecycleState => _platformDispatcher.initialLifecycleState;

  @override
  Locale get locale => _platformDispatcher.locale;

  @override
  List<Locale> get locales => _platformDispatcher.locales;

  @override
  bool get nativeSpellCheckServiceDefined => _platformDispatcher.nativeSpellCheckServiceDefined;

  @override
  Brightness get platformBrightness => _platformDispatcher.platformBrightness;


  @override
  void registerBackgroundIsolate(RootIsolateToken token) {
    _platformDispatcher.registerBackgroundIsolate(token);
  }

  @override
  void requestDartPerformanceMode(DartPerformanceMode mode) {
    _platformDispatcher.requestDartPerformanceMode(mode);
  }

  @override
  void scheduleFrame() {
    _platformDispatcher.scheduleFrame();
  }

  @override
  bool get semanticsEnabled => _platformDispatcher.semanticsEnabled;

  @override
  void sendPlatformMessage(String name, ByteData? data, PlatformMessageResponseCallback? callback) {
    _platformDispatcher.sendPlatformMessage(name, data, callback);
  }

  @override
  void sendPortPlatformMessage(String name, ByteData? data, int identifier, SendPort port) {
    _platformDispatcher.sendPortPlatformMessage(name, data, identifier, port);
  }

  @override
  void setIsolateDebugName(String name) {
    _platformDispatcher.setIsolateDebugName(name);
  }

  @override
  String? get systemFontFamily => _platformDispatcher.systemFontFamily;

  @override
  double get textScaleFactor => _textScaleFactorValue??_platformDispatcher.textScaleFactor;

  double? _textScaleFactorValue;
  
  set textScaleFactorValue(double textScaleFactorValue) {
    _textScaleFactorValue = textScaleFactorValue;
    onTextScaleFactorChanged?.call();
  }

  @override
  void updateSemantics(SemanticsUpdate update) {
    _platformDispatcher.updateSemantics(update);
  }

  @override
  FlutterView? view({required int id}) {
    return _autoSizerViews[id];
  }

  @override
  Iterable<FlutterView> get views => _autoSizerViews.values;


  void _updateViewsAndDisplays() {
    final List<Object> extraDisplayKeys = <Object>[..._autoSizerDisplays.keys];
    for (final Display display in _platformDispatcher.displays) {
      extraDisplayKeys.remove(display.id);
      if (!_autoSizerDisplays.containsKey(display.id)) {
        _autoSizerDisplays[display.id] = AutoSizerDisplay(this, display);
      }
    }
    extraDisplayKeys.forEach(_autoSizerDisplays.remove);

    final List<Object> extraViewKeys = <Object>[..._autoSizerViews.keys];
    for (final FlutterView view in _platformDispatcher.views) {
      late final AutoSizerDisplay display;
      try {
        final Display realDisplay = view.display;
        if (_autoSizerDisplays.containsKey(realDisplay.id)) {
          display = _autoSizerDisplays[view.display.id]!;
        } else {
          display = UnsupportedDisplay(
            this,
            view,
            'PlatformDispatcher did not contain a Display with id ${realDisplay.id}, '
                'which was expected by FlutterView ($view)',
          );
        }
      } catch (error){
        display = UnsupportedDisplay(this, view, error);
      }

      extraViewKeys.remove(view.viewId);
      if (!_autoSizerViews.containsKey(view.viewId)) {
        _autoSizerViews[view.viewId] = AutoSizerView(
          view: view,
          platformDispatcher: this,
          display: display,
        );
      }
    }

    extraViewKeys.forEach(_autoSizerViews.remove);
  }


}