import 'package:flutter/material.dart';

class MinWeatherBox extends StatelessWidget {
  const MinWeatherBox({
    super.key,
    required this.target,
    required this.text,
  });

  final String target;
  final String text;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith();
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(target),
          SizedBox(width: 10),
          Text(text, style: style),
        ],
      ),
    );
  }
}
