import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

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
  void getWeather() async {}
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
            Text('Press Button To Get Weather For My City'),
            ElevatedButton(
              onPressed: () async {
                Dio dio = Dio();
                var response = await dio.get(appState.url);
                appState.weatherResult = response.data;
                print(appState.weatherResult);
              },
              child: Text('Next'),
            ),
          ], // ← 7
        ),
      ),
    );
  }
}
