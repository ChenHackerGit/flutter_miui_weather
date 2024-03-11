import 'dart:math';
import 'package:flutter/material.dart';

import '../models/weather_state.dart';
import 'mid_weather_box.dart';

class MoreDayWeatherCard extends StatelessWidget {
  const MoreDayWeatherCard({
    super.key,
    required this.weatherStateList,
  });

  final List<WeatherState> weatherStateList;

  @override
  Widget build(BuildContext context) {
    List title = ['今天', '明天', '后天'];
    return Card(
      child: Column(
        children: [
          for (int i = 0; i < min(weatherStateList.length, 3); ++i)
            MidWeatherBox(weatherState: weatherStateList[i], title: title[i]),
          // FilledButton(onPressed: () {}, child: Text('查看近三日天气(待实现)')),
        ],
      ),
    );
  }
}
