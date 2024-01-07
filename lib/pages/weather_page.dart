import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:middies/models/weather_model.dart';
import 'package:middies/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService=WeatherService('6e71f12b0ea5d55487a735f54322d7fb');
  Weather? _weather;
  _fetchWeather() async{
    String cityName=await _weatherService.getCurrentCity();
    try{
      final weather=await _weatherService.getWeather(cityName);
      setState(() {
        _weather=weather;
      });
    }

  catch(e){
    print(e);
  }
  }
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition==null)return 'lib/assets/sunny.json';
    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'fog':
      case 'dust':
      case 'mist':
      case 'haze':
      case 'fog':
        return 'lib/assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'lib/assets/rain.json';
      case 'thunderstorm':
        return 'lib/assets/thunder.json';
      case 'clear':
        return 'lib/assets/sunny.json';
      default:
        return 'lib/assets/sunny.json';
    }
  }
  @override
  void initState(){
    super.initState();

    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName??"Loading City...",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainConditions)),
            Text('${_weather?.temperature.round()}°C',
            style: TextStyle(
              fontSize: 30,
            ),),
            Text(_weather?.mainConditions??"",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),


          ],
        ),
      ),
    );
  }
}
