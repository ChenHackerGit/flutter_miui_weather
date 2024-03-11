import 'package:flutter/material.dart';

import '../models/weather_state.dart';

class MaxWeatherBox extends StatelessWidget {
  const MaxWeatherBox({
    super.key,
    required this.weatherState,
  });

  final WeatherState weatherState;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(weatherState.location),
            Text(
              weatherState.degree.toString(),
              style: style,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(weatherState.weather),
                const SizedBox(width: 10),
                Text('最高${weatherState.degreeMax.toString()}'),
                const SizedBox(width: 10),
                Text('最低${weatherState.degreeMin.toString()}'),
                const SizedBox(width: 10),
              ],
            ),
            Card(
              color: theme.colorScheme.onPrimary,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('湿度 ${weatherState.humidity.toString()}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
