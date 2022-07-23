import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '7_18アプリ_YouTube.dart';
import '7_18アプリ_music.dart';
import '7_18アプリ_photo.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        title: Text("ランダムアプリ"),
      ),
      body: Column(
        children:[
          Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("写真選択"),
                  IconButton(
                    icon: Icon(Icons.enhance_photo_translate_outlined),
                    onPressed: (){
                      Navigator.push<void>(
                        context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return PhotoPage();
                              },
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                final Offset begin = Offset(1.0, 0.0); // 右から左
                                // final Offset begin = Offset(-1.0, 0.0); // 左から右
                                final Offset end = Offset.zero;
                                final Animatable<Offset> tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: Curves.easeInOut));
                                final Animation<Offset> offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                    },
                  ),
                ]
              ),
          ),
          TestPage(),
          Container(
            width: 500,
            height: 100,
            child:Column(
              children: [
                Text("ファミポップ３"),
                 Padding(padding: EdgeInsets.only(
                   top: 5,
                   bottom: 5,
                 ),
                 ),
                 IconButton(
                   icon: Icon(Icons.play_arrow),
                   onPressed: (){
                     Navigator.push<void>(
                     context,
                       PageRouteBuilder(
                         pageBuilder: (context, animation, secondaryAnimation) {
                           return AudioPlayerPage();
                         },
                         transitionsBuilder: (context, animation, secondaryAnimation, child) {
                           final Offset begin = Offset(0.0, 1.0); // 下から上
                           // final Offset begin = Offset(0.0, -1.0); // 上から下
                           final Offset end = Offset.zero;
                           final Animatable<Offset> tween = Tween(begin: begin, end: end)
                               .chain(CurveTween(curve: Curves.easeInOut));
                           final Animation<Offset> offsetAnimation = animation.drive(tween);
                           return SlideTransition(
                             position: offsetAnimation,
                             child: child,
                           );
                         },
                       ),
                     );
                   },
                 ),
              ],
            )
          ),
          Container(
            child: Padding(padding: EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            ),
          ),
          ElevatedButton(
            child: const Text("YouTube"),
            onPressed: (){
              Navigator.push<void>(
              context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return YouTubePage();
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    final double begin = 0.0;
                    final double end = 1.0;
                    final Animatable<double> tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<double> doubleAnimation = animation.drive(tween);
                    return FadeTransition(
                      opacity: doubleAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ]
      )
    );
  }
}
class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  String _outputText = "";

  void _handleOutputText(String inputText) {
    setState(() {
      _outputText = inputText;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30,bottom:30),
      child: Column(
        children: <Widget>[
          Text(
            "$_outputText",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            maxLength: 16,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            style: TextStyle(color: Colors.black),
            maxLines: 1,
            onChanged: _handleOutputText,
          ),
        ],
      ),
    );
  }
}

