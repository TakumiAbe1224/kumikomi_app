import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'お天気ニュース'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool ansFlag = false;
  var serverURL;

  // 現在の位置を返す

  Future<String> apiTest(double latitude, double longitude) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    serverURL = "https://api.openweathermap.org/data/2.5/find?lat=${position.latitude.toString()}&lon=${position.longitude.toString()}&appid=a34595d74f59e6fd4e3c1c581d40bdfd&cnt=1&lang=ja";
    Uri _url = Uri.parse(serverURL);
    print('url: ' + _url.toString());
    final response = await http.get(_url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> info = json.decode(utf8.decode(response.bodyBytes));
      print(info);
      String mes=info['message'];
      int co=int.parse(info['cod']);
      WeatherData js=WeatherData.fromJson(info['list'][0]);
      ApiData d = new ApiData(mes,co,js);
      String dtt=convertTime(d.data.dt);
      String result = '${d.data.name}(${position.longitude.toString()},${position.latitude.toString()})の${dtt}の気温は${d.data.main.temp.toString().substring(0,5)}度\n'+
          '天気は${d.data.weather.main},気圧は${d.data.main.pressure}hPaです';
      return result;
    } else {
      print("error:" + response.body);
      return "error";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: (){
                setState(() {
                  ansFlag = true;
                });
              },

              child: const Text('今日の天気は？',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if(ansFlag == true)FutureBuilder(
                future: apiTest(35.6785, 139.6823),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CircularProgressIndicator();
                  }
                  // エラー発生時はエラーメッセージを表示
                  if (snapshot.hasError) {
                    ansFlag = false;
                    print(snapshot.error);
                    return Text("エラーが発生しました");
                  }
                  // データがnullでないかチェック
                  if (snapshot.hasData) {
                    ansFlag = false;
                    return Text(snapshot.data ?? '');
                  } else {
                    return Text("データが存在しません");
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}

class ApiData {
  final String message;
  final int cod;
  final WeatherData data;
  ApiData(this.message, this.cod, this.data);
  ApiData.fromJson(Map<String, dynamic> json)
      :
        message = json['message'].toString(),
        cod = int.parse(json['cod']),
        data = WeatherData.fromJson(json['list'][0]);
}

class WeatherData{
  final String id;
  final String name;
  final Coord coord;
  final MainWeatherData main;
  final int dt;
  final Weather weather;

  WeatherData(this.id, this.name, this.coord, this.main, this.dt, this.weather);

  WeatherData.fromJson(Map<String, dynamic> json)
      :
        id = json['id'].toString(),
        name = json['name'].toString(),
        coord = Coord.fromJson(json),
        main = MainWeatherData.fromJson(json),
        dt = json['dt'],
        weather = Weather.fromJson(json);

}

class MainWeatherData{

  MainWeatherData(this.temp, this.feelsLike, this.tempMax, this.tempMin, this.pressure, this.humidity, this.seaLevel, this.grndLevel);

  MainWeatherData.fromJson(Map<String, dynamic> json)
      :
        temp = json['main']["temp"] - 273 ?? -9999,
        tempMin = json['main']["temp_min"] - 273 ?? -9999,
        tempMax = json['main']["temp_max"]- 273 ?? -9999,
        feelsLike = json['main']["feels_like"] - 273 ?? -9999,
        pressure = json['main']["pressure"] ?? -9999,
        humidity = json['main']["humidity"] ?? -9999,
        seaLevel = json['main']["sea_level"] ?? -9999,
        grndLevel = json['main']["grnd_level"] ?? -9999;


  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;
}

class Weather {

  final int id;
  final String main;
  final String description;
  final String icon;

  Weather(this.main, this.description, this.icon, this.id);

  Weather.fromJson(Map<String, dynamic> json)
      :
        id = json['weather'][0]['id'],
        main = json['weather'][0]['main'],
        description = json['weather'][0]['description'],
        icon = json['weather'][0]['icon'];
}

class Coord{
  final double lat;
  final double lon;

  Coord(this.lat, this.lon);

  Coord.fromJson(Map<String, dynamic> json)
      :
        lat = json['coord']['lat'],
        lon = json['coord']['lon'];
}
String convertTime(int t) {
  //int型からDateTime型に変換
  initializeDateFormatting('ja');
  int tt=t*1000000;
  DateTime date = DateTime.fromMicrosecondsSinceEpoch(tt);
  String time = DateFormat.yMMMd('ja').format(date).toString();
  return time; //例 2020年08月14日
}