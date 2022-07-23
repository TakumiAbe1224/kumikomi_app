import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter layout demo"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 100,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 100.0,
                  padding: const EdgeInsets.all(30),
                  alignment: const Alignment(-5,-0.5),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.add,color: Colors.blue),
                        Container(
                          child: Text("label",
                            style:TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
                Text("Hello"),
              ],
            ),
            Container(
              width: 500,
              child: Text("aiueoaiueoaiueoaiueoaiueoaiueoaiueokakikukekokakikukekokakikukekokakikukekosasisusesosasisusesosasisusesosasisusesotatitutetotatitutetotatitutetotatituteto"),
              padding: const EdgeInsets.all(30),
            ),
          ],
        ),
      ),
    );
  }
}
