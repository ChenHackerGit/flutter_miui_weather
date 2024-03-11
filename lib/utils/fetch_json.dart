import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_miui_weather/android/get_location.dart';
import 'package:http/http.dart' as http;

List<dynamic>? lazyLocation;
var lazyFetchJson = <String, dynamic>{};

Future<dynamic> fetchJson(String url, {String targetLocation = 'auto'}) async {
  if (lazyFetchJson.containsKey(url + targetLocation)) {
    return lazyFetchJson[url + targetLocation];
  }
  late String requestUrl;
  if (targetLocation != 'auto') {
    requestUrl = '$url&location=$targetLocation';
  } else {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      requestUrl = '$url&location=ip';
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      lazyLocation ??= await getLocation();

      print(lazyLocation);
      requestUrl = '$url&location=${lazyLocation?[0]}:${lazyLocation?[1]}';
    }
  }
  print("url:$requestUrl");
  final response = await http.get(Uri.parse(requestUrl));
  print("after http.get");

  if (response.statusCode == 200) {
    lazyFetchJson[url + targetLocation] =
        jsonDecode(response.body) as Map<String, dynamic>;
    return lazyFetchJson[url + targetLocation];
  } else {
    print(response.body);
    throw Exception('Failed to load album');
  }
}
