import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import '7_18アプリ_firstpage.dart';

void main(){
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

