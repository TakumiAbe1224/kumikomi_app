import 'package:flutter/material.dart';

void main(){
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  Widget mytext = Container(
      padding: EdgeInsets.all(32),
      child:Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child :Container(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("金閣寺",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("(鹿苑寺)")
                      ]
                  )
              ),
            ),
            Icon(Icons.star,
              color: Colors.red,
            ),
            Text("4.8"),
          ]
      )
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title:Text("Flutter layout demo"),
            ),
            body: Column(
                children:[
                  mytext,
                ]
            )
        )
    );
  }
}