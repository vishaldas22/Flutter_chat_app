import 'package:flutter/material.dart';
import 'ChatScreen.dart';
import 'package:flutter/foundation.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chat App",
      theme: defaultTargetPlatform == TargetPlatform.iOS         //new
          ? kIOSTheme                                              //new
          : kDefaultTheme,
      home: new ChatScreen(),
    );
  }
}
