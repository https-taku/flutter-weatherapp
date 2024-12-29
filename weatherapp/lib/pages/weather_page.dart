import 'dart:developer';

import 'package:weatherapp/models/weather_models.dart';
import 'package:weatherapp/service/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny day.json';
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'fog':
        return 'assets/cloudy.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy day.json';

      case 'thunderstorm':
        return 'assets/thunderstorm.json';

      case 'clear':
      case 'sun':
        return 'assets/sunny day.json';

      default:
        return 'assets/sunny day.json';
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Weather App')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // city name

          Text(_weather?.cityName ?? 'Loading city...'),

          // animation
          Lottie.asset(
            getWeatherAnimation(_weather?.mainCondition),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),

          // temperature
          Text('${_weather?.temperature.round()} Degrees Celcius'),

          // weather condition
          Text(_weather?.mainCondition ?? ''),
        ]),
      ),
    );
  }
}
