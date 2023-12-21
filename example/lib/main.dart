import 'dart:ui';

import 'package:auto_sizer/auto_sizer_platform_dispatcher.dart';
import 'package:flutter/material.dart';
import 'package:auto_sizer/auto_sizer.dart';

void main() {
  runAutoApp(const MyApp(),designSize: const Size(360,667));
  // runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  double ratio = 0.0;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData autoMediaQueryData = MediaQuery.of(context);
    print('defaultMediaQueryData:-------flutterView=${PlatformDispatcher.instance.implicitView!.devicePixelRatio}---------------------');
    print('autoMediaQueryData:-------devicePixelRatio=${AutoSizerPlatformDispatcher.instance.implicitView!.devicePixelRatio}-------');

    double width = (120*(1+ratio)).roundToDouble();
    double height = (120*(1+ratio)).roundToDouble();
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: const Text('AutoSizer Demo'),),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: autoMediaQueryData.viewPadding.top),
                child: Slider(value: ratio, onChanged: (value){
                  setState(() {
                    ratio = value;
                  });
                }),
              ),
              const Text('设置尺寸：'),
              Wrap(
                children: [
                  Container(
                    width: width,
                    height: height,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text('w: $width\nh: $height',style: const TextStyle(color: Colors.white),),
                  ),
                  Container(
                    width: width,
                    height: height,
                    color: Colors.amber,
                    alignment: Alignment.center,
                    child: Text('w: $width\nh: $height',style: const TextStyle(color: Colors.white),),
                  ),
                  Container(
                    width: width,
                    height: height,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text('w: $width\nh: $height',style: const TextStyle(color: Colors.white),),
                  ),
                ],
              ),
              const Text('使用Expanded：'),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: height,
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: Text('h: $height',style: const TextStyle(color: Colors.white),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: height,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Text('h: $height',style: const TextStyle(color: Colors.white),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: height,
                      color: Colors.amber,
                      alignment: Alignment.center,
                      child: Text('h: $height',style: const TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
