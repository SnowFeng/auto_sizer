
import 'dart:ui';

enum SizerMode{
  portrait,//竖屏适配
  landscape//横屏适配
}

class AutoSizerUtil {

  static FlutterView get _view => PlatformDispatcher.instance.implicitView!;

  static AutoSizerUtil get instance => _instance;

  static final AutoSizerUtil _instance = AutoSizerUtil._();

  AutoSizerUtil._();

  double _devicePixelRatio = _view.devicePixelRatio;

  void init(Size designSize,{SizerMode mode = SizerMode.portrait}){
    if (mode == SizerMode.portrait) {
      _devicePixelRatio =
          _view.physicalSize.width / designSize.width;
    } else {
      _devicePixelRatio =
          _view.physicalSize.height / designSize.height;
    }
  }

  double get devicePixelRatio => _devicePixelRatio;

}
