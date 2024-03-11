import 'package:flutter/material.dart';
import 'package:flutter_miui_weather/main.dart';
import 'package:provider/provider.dart';

class LocationsEditPage extends StatefulWidget {
  const LocationsEditPage({super.key});

  @override
  State<LocationsEditPage> createState() => _LocationsEditPageState();
}

class _LocationsEditPageState extends State<LocationsEditPage> {
  late String inputText;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    List<String> locations = appState.locations;

    return Scaffold(
        appBar: AppBar(
          title: const Text('城市管理'),
        ),
        body: ListView(
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "城市",
                  hintText: "请输入城市名称或者缩写",
                  prefixIcon: Icon(Icons.search)),
              onChanged: (value) {
                inputText = value;
              },
            ),
            IconButton(
                onPressed: () {
                  appState.addLocation(inputText);
                },
                icon: Icon(Icons.add)),
            for (String location in locations)
              Card(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // leading: Text(location),
                    children: [
                      SizedBox(width: 10),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(location),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          appState.deleteLocation(location);
                        },
                      )
                    ]
                    // trailing: Text(each.value['details']),
                    ),
              )
          ],
        ));
  }
}
