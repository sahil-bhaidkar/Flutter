import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('6513761530470cfadae354e51ecba399');
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    // Handling different weather conditions with Lottie animations
    if (mainCondition == null) return 'assets/sunny.json'; // Default animation for unknown condition
    switch (mainCondition.toLowerCase()) {
      case 'clear':
        return 'assets/sunny.json';
      case 'clouds':
        return 'assets/cloudy.json';
      case 'rain':
        return 'assets/rainy.json';
      case 'snow':
        return 'assets/snowy.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'mist':
      case 'fog':
        return 'assets/foggy.json';
      default:
        return 'assets/sunny.json'; // Default animation for unknown condition
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityname ?? "loading city.."),
            // Displaying weather animation based on the weather condition
            Lottie.asset(getWeatherAnimation(_weather?.maincondition)),
            Text('${_weather?.temperature?.round() ?? ""}°C'),
          ],
        ),
      ),
    );
  }
}