# auto_sizer

自动适配各种像素密度的屏幕，只需要设置好设计图基准尺寸，编写代码时直接使用设计尺寸即可。

## 使用
### 方式一
```dart
runAutoApp(const MyApp(),designSize: 设计图基准尺寸(如：375*667));
```
### 方式二
```dart
AutoSizerUtil.instance.init(设计图基准尺寸(如：375*667), mode: mode);
AutoSizerWidgetsBinding.ensureInitialized();
runApp(const MyApp());
```
## 注意事项
1、初始化前不能使用WidgetsFlutterBinding.ensureInitialized()等相关操作，因为WidgetsBinding是单例的，只能初始化一次
2、不要使用PlatformDispatcher.instance获取调度器，而是用AutoSizerPlatformDispatcher.instance获取，前者用的是真实像素密度。
3、本插件通过修改FlutterView的devicePixelRatio值以达到适配的目的，因此只能全局通用而不能针对小部件单独配置。同时如AppBar高度等sdk内部控件尺寸也会随像素密度改变，使用时请注意。

