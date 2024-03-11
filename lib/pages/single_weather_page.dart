import 'package:flutter/material.dart';
import 'package:flutter_miui_weather/utils/fetch_json.dart';
import 'package:flutter_miui_weather/widgets/max_weather_box.dart';
import 'package:flutter_miui_weather/widgets/min_weather_box.dart';
import 'package:flutter_miui_weather/widgets/more_day_weather_card.dart';

import '../models/weather_state.dart';

class SingleWeatherPage extends StatefulWidget {
  final String targetLocation;

  const SingleWeatherPage({
    super.key,
    required this.targetLocation,
  });

  @override
  State<SingleWeatherPage> createState() => _SingleWeatherPageState();
}

class _SingleWeatherPageState extends State<SingleWeatherPage> {
  late Future<dynamic> nowFutureJson, dailyFutureJson, suggestionFutureJson;

  @override
  void initState() {
    super.initState();

    nowFutureJson = fetchJson(
        'https://api.seniverse.com/v3/weather/now.json?key=YouKey&language=zh-Hans&unit=c',
        targetLocation: widget.targetLocation);
    dailyFutureJson = fetchJson(
        'https://api.seniverse.com/v3/weather/daily.json?key=YouKey&language=zh-Hans&unit=c&start=0&days=5',
        targetLocation: widget.targetLocation);
    suggestionFutureJson = fetchJson(
        'https://api.seniverse.com/v3/life/suggestion.json?key=YouKey&language=zh-Hans&days=5',
        targetLocation: widget.targetLocation);
  }

  @override
  Widget build(BuildContext context) {
    var weatherState = WeatherState();
    List<WeatherState> moreWeatherState = [];

    Widget suggestionList = Text('加载中');

    Widget myBuider() {
      return SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              MaxWeatherBox(weatherState: weatherState),
            ],
          ),
          MoreDayWeatherCard(weatherStateList: moreWeatherState),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 1.618,
            children: [
              MinWeatherBox(target: '湿度', text: '${weatherState.humidity}%'),
              MinWeatherBox(
                  target: '${weatherState.windDirection}风',
                  text: '${weatherState.windScale}级'),
            ],
          ),
          suggestionList,
        ]),
      );
    }

    return Scaffold(
      body: FutureBuilder<dynamic>(
          future: Future.wait(
              [nowFutureJson, dailyFutureJson, suggestionFutureJson]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              weatherState = WeatherState(
                  location: snapshot.data[0]['results'][0]['location']['name'],
                  degree: int.parse(
                      snapshot.data[0]['results'][0]['now']['temperature']),
                  weather: snapshot.data[0]['results'][0]['now']['text'],
                  degreeMax: int.parse(
                      snapshot.data[1]['results'][0]['daily'][0]['high']),
                  degreeMin: int.parse(
                      snapshot.data[1]['results'][0]['daily'][0]['low']),
                  humidity: int.parse(
                      snapshot.data[1]['results'][0]['daily'][0]['humidity']),
                  windDirection: snapshot.data[1]['results'][0]['daily'][0]
                      ['wind_direction'],
                  windScale: int.parse(snapshot.data[1]['results'][0]['daily']
                      [0]['wind_scale']));
              moreWeatherState = [];
              for (var each in snapshot.data[1]['results'][0]['daily']) {
                moreWeatherState.add(WeatherState(
                  location: snapshot.data[0]['results'][0]['location']['name'],
                  degree: int.parse(
                      snapshot.data[0]['results'][0]['now']['temperature']),
                  weather: snapshot.data[0]['results'][0]['now']['text'],
                  degreeMax: int.parse(each['high']),
                  degreeMin: int.parse(each['low']),
                  humidity: int.parse(each['humidity']),
                ));
              }
              Map<String, String> titles = {
                'ac': '空调开启',
                'air_pollution': '空气',
                'airing': '晾晒',
                'allergy': '过敏',
                'beer': '啤酒',
                'boating': '划船',
                'car_washing': '洗车',
                'chill': '风寒',
                'comfort': '舒适度',
                'dating': '约会',
                'dressing': '穿衣',
                'fishing': '钓鱼',
                'flu': '感冒',
                'hair_dressing': '美发',
                'kiteflying': '放风筝',
                'makeup': '化妆',
                'mood': '心情',
                'morning_sport': '晨练',
                'night_life': '夜生活',
                'road_condition': '路况',
                'shopping': '购物',
                'sport': '运动',
                'sunscreen': '防晒',
                'traffic': '交通',
                'travel': '旅游',
                'umbrella': '雨伞',
                'uv': '紫外线',
              };

              suggestionList = Column(
                children: [
                  for (var each in snapshot
                      .data[2]['results'][0]['suggestion'][0].entries
                      .skip(1)
                      .toList())
                    Card(
                      child: ListTile(
                        leading: Text(titles[each.key]!),
                        title: Text(each.value['brief']),
                        subtitle: Text(each.value['details']),
                        // trailing: Text(each.value['details']),
                      ),
                    )
                ],
              );

              // print(snapshot.data['results'][0]['location']);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return myBuider();
          }),
    );
  }
}
