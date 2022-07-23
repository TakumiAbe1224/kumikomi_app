import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '7_18アプリ_firstpage.dart';

class YouTubePage extends StatelessWidget {
  const YouTubePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ytcl = YoutubePlayerController(
      initialVideoId: "UuLFNhTYhOQ",
    );
    return  MaterialApp(
        home: YoutubePlayerControllerProvider(
            controller: ytcl,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
                title: Text("動画再生"),
              ),
              body: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                      children: [
                        //(3) プレーヤーiframeで再生枠を作ります
                        const YoutubePlayerIFrame(),
                        const Padding(padding: EdgeInsets.all(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  //(4) コントローラーのメソッドで操作
                                  ytcl.play();
                                },
                                child: const Text("play")),
                            ElevatedButton(
                                onPressed: () {
                                  ytcl.pause();
                                },
                                child: const Text("pause")),
                            ElevatedButton(
                              onPressed: (){
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => FirstPage(),
                                  ),
                                );
                              },
                              child: Text("戻る"),
                            )
                              ],
                        ),
                      ],
                    ),
                ),
            ),
        ),
    );
  }
  }

