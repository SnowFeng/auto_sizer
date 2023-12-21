import 'dart:ui';

import 'package:auto_sizer/auto_sizer_util.dart';

import 'auto_sizer_platform_dispatcher.dart';

class AutoSizerView implements FlutterView{

  final FlutterView _view;

  final AutoSizerPlatformDispatcher _platformDispatcher;

  final AutoSizerDisplay _display;

  AutoSizerView({
    required FlutterView view,
    required AutoSizerPlatformDispatcher platformDispatcher,
    required AutoSizerDisplay display,
  }):
        _view = view,
        _platformDispatcher = platformDispatcher,
        _display = display;


  @override
  double get devicePixelRatio => _display.devicePixelRatio;

  @override
  AutoSizerDisplay get display => _display;

  @override
  List<DisplayFeature> get displayFeatures => _view.displayFeatures;

  @override
  GestureSettings get gestureSettings => _gestureSettings ?? _view.gestureSettings;
  GestureSettings? _gestureSettings;
  set gestureSettings(GestureSettings value) {
    _gestureSettings = value;
    platformDispatcher.onMetricsChanged?.call();
  }

  @override
  AutoSizerViewPadding get padding => AutoSizerViewPadding._wrap(_view.padding);

  @override
  Rect get physicalGeometry{
    Rect value = _physicalGeometry ?? _view.physicalGeometry;
    if (_physicalSize != null) {
      value = value.topLeft & _physicalSize!;
    }
    return value;
  }

  Rect? _physicalGeometry;
  set physicalGeometry(Rect value) {
    _physicalGeometry = value;
    platformDispatcher.onMetricsChanged?.call();
  }

  @override
  Size get physicalSize {
    return _physicalSize ?? _physicalGeometry?.size ?? _view.physicalSize;
  }
  Size? _physicalSize;
  set physicalSize(Size value) {
    _physicalSize = value;
    platformDispatcher.onMetricsChanged?.call();
  }

  @override
  AutoSizerPlatformDispatcher get platformDispatcher => _platformDispatcher;

  @override
  void render(Scene scene) {
    _view.render(scene);
  }

  @override
  AutoSizerViewPadding get systemGestureInsets => _systemGestureInsets ?? AutoSizerViewPadding._wrap(_view.systemGestureInsets);

  AutoSizerViewPadding? _systemGestureInsets;
  set systemGestureInsets(AutoSizerViewPadding value) {
    _systemGestureInsets = value;
    platformDispatcher.onMetricsChanged?.call();
  }

  @override
  void updateSemantics(SemanticsUpdate update) {
    _view.updateSemantics(update);
  }

  @override
  int get viewId => _view.viewId;

  @override
  AutoSizerViewPadding get viewInsets => _viewInsets ?? AutoSizerViewPadding._wrap(_view.viewInsets);
  AutoSizerViewPadding? _viewInsets;
  set viewInsets(AutoSizerViewPadding value) {
    _viewInsets = value;
    platformDispatcher.onMetricsChanged?.call();
  }

  @override
  AutoSizerViewPadding get viewPadding => _viewPadding ?? AutoSizerViewPadding._wrap(_view.viewPadding);
  AutoSizerViewPadding? _viewPadding;
  set viewPadding(AutoSizerViewPadding value) {
    _viewPadding = value;
    platformDispatcher.onMetricsChanged?.call();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }

}

class AutoSizerDisplay implements Display {
  final Display _display;

  final AutoSizerPlatformDispatcher _platformDispatcher;

  AutoSizerDisplay(
      AutoSizerPlatformDispatcher platformDispatcher, Display display)
      : _platformDispatcher = platformDispatcher,
        _display = display;

  @override
  double get devicePixelRatio => AutoSizerUtil.instance.devicePixelRatio;

  @override
  int get id => _display.id;

  @override
  double get refreshRate => _display.refreshRate;


  @override
  Size get size => _display.size;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }
}

class UnsupportedDisplay implements AutoSizerDisplay {
  UnsupportedDisplay(this._platformDispatcher, this._view, this.error);

  final FlutterView _view;
  final Object? error;

  @override
  final AutoSizerPlatformDispatcher _platformDispatcher;

  @override
  double get devicePixelRatio => _view.devicePixelRatio;



  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnsupportedError(
      'The Display API is unsupported in this context. '
          'As of the last metrics change on PlatformDispatcher, this was the error '
          'given when trying to prepare the display for autoSizing: $error',
    );
  }
}

class AutoSizerViewPadding implements ViewPadding{

  const AutoSizerViewPadding({
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  });

  AutoSizerViewPadding._wrap(ViewPadding base) :
        left = base.left,
        top = base.top,
        right = base.right,
        bottom = base.bottom;

  static const AutoSizerViewPadding zero = AutoSizerViewPadding();

  @override
  final double left;

  @override
  final double top;

  @override
  final double right;

  @override
  final double bottom;

  @override
  String toString() {
    return 'AutoSizerViewPadding($left, $top, $right, $bottom)';
  }

}
