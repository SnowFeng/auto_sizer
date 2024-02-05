
import 'dart:ui';

import 'auto_sizer_binding.dart';

export 'auto_sizer_binding.dart';
export 'auto_sizer_window.dart';
export 'auto_sizer_platform_dispatcher.dart';

enum SizerMode{
  portrait,//竖屏适配（适配宽度，高度自适应）
  landscape//横屏适配（适配高度，宽度自适应）
}

class AutoSizer {
  static FlutterView get _view => PlatformDispatcher.instance.implicitView!;

  static AutoSizer get instance => _instance;

  static final AutoSizer _instance = AutoSizer._();

  AutoSizer._();

  double _devicePixelRatio = _view.devicePixelRatio;

  Size _designSize = _view.physicalSize;

  SizerMode _mode = SizerMode.portrait;

  void init(Size designSize,{SizerMode mode = SizerMode.portrait}){
    _designSize = designSize;
    _mode = mode;
    _update();
    AutoSizerWidgetsBinding.ensureInitialized();
  }

  void _update(){
    double width = _designSize.width;
    double height = _designSize.height;
    Size changedSize = Size(width, height);
    if(_view.physicalSize.width>_view.physicalSize.height){//横屏时
      if(width<height){
        changedSize = Size(height, width);
      }
    }else{
      if(width>height){
        changedSize = Size(height, width);
      }
    }
    _designSize = changedSize;
    if (_mode == SizerMode.portrait) {
      _devicePixelRatio =
          _view.physicalSize.width / changedSize.width;
    } else {
      _devicePixelRatio =
          _view.physicalSize.height / changedSize.height;
    }
  }

  ///当屏幕发生变化时，如屏幕旋转
  void onMetricsChanged(){
    _update();
  }

  double get devicePixelRatio => _devicePixelRatio;

  Size get designSize => _designSize;
}
