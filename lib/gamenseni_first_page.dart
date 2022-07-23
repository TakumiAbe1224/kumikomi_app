import 'package:flutter/material.dart';
import 'package:kumikomi_app/gamenseni_second_page.dart';


class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ファースト"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("次の画面へ"),
          onPressed: (){
            //ボタンが押されたときに実行させたいコードを書く
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SecondPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
