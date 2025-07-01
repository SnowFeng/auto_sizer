import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:auto_sizer/auto_sizer.dart';

bool isAuto = true;

Size designSize = const Size(560,667);

void main() {
  if(isAuto){
    runAutoApp(const MyApp(),designSize: designSize);
  }else{
    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    MediaQueryData autoMediaQueryData = MediaQuery.of(context);
    bool isPortrait = autoMediaQueryData.orientation==Orientation.portrait;
    print('--------------autoMediaQueryData.Size: ${autoMediaQueryData.size.width}*${autoMediaQueryData.size.height}---------------------');
    final deviceWidth = autoMediaQueryData.size.width/3;
    final deviceHeight = autoMediaQueryData.size.height/3;


    final orientationDesignSize = isPortrait?designSize:Size(designSize.height, designSize.width);
    final width = orientationDesignSize.width/3;
    final height = orientationDesignSize.height/3;

    List<Widget> deviceChildren = [
      _buildDeviceSizeWidget(isPortrait,deviceWidth, deviceHeight, Colors.red),
      _buildDeviceSizeWidget(isPortrait,deviceWidth, deviceHeight, Colors.amber),
      _buildDeviceSizeWidget(isPortrait,deviceWidth, deviceHeight, Colors.blue)
    ];

    List<Widget> designChildren = [
      _buildDesignSizeWidget(width, height, Colors.red),
      _buildDesignSizeWidget(width, height, Colors.amber),
      _buildDesignSizeWidget(width, height, Colors.blue),
    ];

    List<Widget> children = [
      Column(
        children: [
          const SizedBox(height: 38,),
          const Text('设计图尺寸：',style: TextStyle(fontSize: 16),),
          Text('${orientationDesignSize.width}*${orientationDesignSize.height}',style: const TextStyle(fontSize: 16),),
          const SizedBox(height: 10,),
          const Text('屏幕尺寸：',style: TextStyle(fontSize: 16),),
          Text('${autoMediaQueryData.size.width.toStringAsFixed(2)}*${autoMediaQueryData.size.height.toStringAsFixed(2)}',style: const TextStyle(fontSize: 16),),
          const SizedBox(height: 10,),
          Text('是否自动适配：${isAuto?'是' : '否'}',style: isAuto? const TextStyle(color: Colors.blue,fontSize: 16) :const TextStyle(color: Colors.red,fontSize: 16)),
          const SizedBox(height: 20,),
        ],
      ),
      const Text('按设计图尺寸：',style: TextStyle(fontSize: 16),),
      isPortrait?Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: designChildren):Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: designChildren,),
      const SizedBox(height: 20,),
      const Text('按屏幕尺寸：',style: TextStyle(fontSize: 16),),
      isPortrait?Row(children: deviceChildren):Column(children: deviceChildren,)
    ];


    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          scrollDirection: isPortrait?Axis.vertical: Axis.horizontal,
          child: isPortrait?Column(
              children: children):Row(children: children,),
        ),
      ),
    );
  }

  Widget _buildDesignSizeWidget(double designWidth, double designHeight,Color color){
    return  Container(
      width: designWidth,
      height: designHeight,
      color: color,
      alignment: Alignment.center,
      child: Text('w: ${designWidth.toStringAsFixed(2)}\nh: ${designHeight.toStringAsFixed(2)}',style: const TextStyle(color: Colors.white,fontSize: 16),),
    );
  }

  Widget _buildDeviceSizeWidget(bool isPortrait,double deviceWidth, double deviceHeight,Color color){
    return Expanded(
      child: Container(
        height: isPortrait?deviceHeight:null,
        width: isPortrait?null:deviceWidth,
        color: color,
        alignment: Alignment.center,
        child: Text('w: ${deviceWidth.toStringAsFixed(2)}\nh: ${deviceHeight.toStringAsFixed(2)}',style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
