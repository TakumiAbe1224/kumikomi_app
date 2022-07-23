import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.yellow,
        title: const Text("セカンド"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("次の画面へ"),
          onPressed: (){
            //ボタンが押されたときに実行させたいコードを書く
          },
        ),
      ),
    );
  }
}
