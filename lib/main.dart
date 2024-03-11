import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'models/weather_state.dart';
import 'pages/locations_edit_page.dart';
import 'widgets/my_page_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'flutter_miui_weather',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_miui_weather'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LocationsEditPage(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
          SizedBox(width: 30),
        ],
      ),
      body: WeatherPageView(),
    );
  }
}

class MyAppState extends ChangeNotifier {
  WeatherState weatherState = WeatherState();
  List<String> locations = [
    'auto',
    'shangrao',
    'lianyungang',
    'haerbin',
  ]; //只有第一个元素可以为auto，因为这是后续的定位缓存的默认情况
  void addLocation(String location) {
    if (locations.contains(location)) {
      locations.remove(location);
    } else {
      locations.add(location);
    }
    notifyListeners();
  }

  void deleteLocation(String location) {
    locations.remove(location);
    notifyListeners();
  }
}

class WeatherPageView extends StatefulWidget {
  const WeatherPageView({
    super.key,
  });

  @override
  State<WeatherPageView> createState() => _WeatherPageViewState();
}

class _WeatherPageViewState extends State<WeatherPageView> {
  late Future<dynamic> getlcoationFutureState;

  @override
  void initState() {
    super.initState();
    if (defaultTargetPlatform == TargetPlatform.android) {
      getlcoationFutureState = Permission.location.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      return MyPageView();
    } else {
      // return MyChangeNotifierProvider();
      // }
      return FutureBuilder(
        future: getlcoationFutureState,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyPageView();
          } else {
            return Text('正在获取定位权限');
          }
        },
      );
    }
  }
}
