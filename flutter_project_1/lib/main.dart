import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'flutter_project_1',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 79, 254, 252)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String url =
      'https://api.openweathermap.org/data/2.5/weather?lat=42.5803&lon=83.0302&units=imperial&appid=ae93a8df4eb012916dd53498f4b2cc0a';

  var weatherResult = {};
  var city = '';
  var temp = '';
  var desc = '';
  void getWeather() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=imperial&appid=ae93a8df4eb012916dd53498f4b2cc0a';
    Dio dio = Dio();
    var response = await dio.get(url);
    weatherResult = response.data;
    city = weatherResult['name'];
    temp = weatherResult['main']['temp'].toString();
    desc = weatherResult['weather'][0]['description'];
    notifyListeners();
    print(weatherResult);
    print("Latitude: ${position.latitude} Longitude: ${position.longitude}");
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Allow Location Access and Press Button'),
            Text('City: ${appState.city}'),
            Text('Temperature: ${appState.temp}'),
            Text('Description: ${appState.desc}'),
            ElevatedButton(
              onPressed: () {
                appState.getWeather();
              },
              child: Text('Get Weather'),
            ),
          ], // ← 7
        ),
      ),
    );
  }
}
