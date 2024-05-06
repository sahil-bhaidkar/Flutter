import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WeatherPage> {
  // API key for weather service
  final _weatherService = WeatherService('6513761530470cfadae354e51ecba399');

  // Weather object to store weather data
  Weather? _weather;

  // Fetch weather data
  _fetchWeather() async {
    // Get current city name
    String cityName = await _weatherService.getCurrentCity();

    // Get weather for the current city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // Initialize state and fetch weather data
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Corrected property name
            children: [
              // Display city name or "loading city.." if data is not available
              Text(_weather?.cityname ?? "loading city.."),

              // Display temperature in degrees Celsius or an empty string if data is not available
              Text('${_weather?.temperature?.round() ?? ""}°C'),
            ],
          )
      ),
    );
  }
}