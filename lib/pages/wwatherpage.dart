import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myweather/model/weathermodel.dart';

import '../service/weatherservice.dart';


class weatherpage extends StatefulWidget {
  const weatherpage({Key? key}) : super(key: key);

  @override
  State<weatherpage> createState() => _weatherpageState();
}

class _weatherpageState extends State<weatherpage> {

  final _WeatherService = WeatherService('6de1bd4d1f3b3f2258bca841daec302b');
  Weather? _weather;

  _fetchweather() async {

    String cityName = await _WeatherService.getCurrentCity();

    try{
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) return 'assets/sun.json';

    switch (mainCondition.toLowerCase()) {
      case 'cloud':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/scloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/cloud.json';
      case 'thunderstorm':
        return 'assets/the.json';
      case 'clear':
        return 'assets/sun.json';
        default:
          return 'assets/sun.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.location_on, color: Colors.grey,),
                Text(_weather?.cityName?? " Loading ...", style: TextStyle(color: Colors.grey, fontSize: 22)),
              ],
            ),

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            Text('${_weather?.temperature.round()} °', style: TextStyle(color: Colors.grey, fontSize: 22)),

            Text(_weather?.mainCondition ?? "", style: TextStyle(color: Colors.grey, fontSize: 22))
          ],
        ),
      ),

    );
  }
}
