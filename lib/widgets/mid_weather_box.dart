import 'package:flutter/material.dart';

import '../models/weather_state.dart';

class MidWeatherBox extends StatelessWidget {
  const MidWeatherBox({
    super.key,
    required this.weatherState,
    required this.title,
  });

  final WeatherState weatherState;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title),
          SizedBox(width: 5),
          Text(weatherState.weather),
          SizedBox(width: 30),
          Icon(Icons.sunny),
          SizedBox(width: 30),
          Text('${weatherState.degreeMin}'),
          SizedBox(width: 20),
          Text('${weatherState.degreeMax}'),
        ],
      ),
    );
  }
}
