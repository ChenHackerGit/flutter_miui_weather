import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui_weather/main.dart';
import 'package:flutter_miui_weather/pages/single_weather_page.dart';
import 'package:provider/provider.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final controller = PageController();
  bool isDragging = false;
  @override
  Widget build(BuildContext context) {
    var myAppState = context.watch<MyAppState>();
    List<String> locations = myAppState.locations;
    if (defaultTargetPlatform == TargetPlatform.windows) {
      return Listener(
          onPointerDown: (_) {
            setState(() {
              isDragging = true;
            });
          },
          onPointerUp: (_) {
            setState(() {
              isDragging = false;
            });
          },
          onPointerMove: (event) {
            if (isDragging) {
              if (event.delta.dx > 0) {
                controller.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else if (event.delta.dx < 0) {
                controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }
          },
          child: PageView(
            controller: controller,
            children: [
              for (var location in locations)
                SingleWeatherPage(targetLocation: location)
              // Placeholder(), Placeholder(),
            ],
          ));
    } else {
      return PageView(
        controller: controller,
        children: [
          for (var location in locations)
            SingleWeatherPage(targetLocation: location)
          // Placeholder(), Placeholder(),
        ],
      );
    }
  }
}
