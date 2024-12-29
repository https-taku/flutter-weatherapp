import 'dart:developer';

import 'package:weatherapp/models/weather_models.dart';
import 'package:weatherapp/service/weather_service.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService =
      WeatherService("4aa97358062f46640efed76f3bd1218a");
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    // get current City
    String cityName = await _weatherService.getCurrentCity();
    // get weather for current City

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //catch any errors
    catch (e) {
      print(e);
    }
  }

  //initial state

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(_weather?.cityName ?? 'Loading city...'),
          Text('${_weather?.temperature.round()} Degrees Celcius'),
        ]),
      ),
    );
  }
}
