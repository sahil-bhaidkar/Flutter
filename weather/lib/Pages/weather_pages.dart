import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WeatherPage> {
  //api key

  final _weatherService = WeatherService([apiKey]);
  Weather? _weather;

  //fetch weather

  _fetchweather() async {
    //get curr city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city

    try {
      final Weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = Weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
