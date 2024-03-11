import 'package:flutter_z_location/flutter_z_location.dart';

getLocation() async {
  // return Permission.location.request().then((value) async {
// 获取GPS定位经纬度
  final coordinate = await FlutterZLocation.getCoordinate();
// 经纬度反向地理编码获取地址信息(省、市、区)
  final res1 = await FlutterZLocation.geocodeCoordinate(
      coordinate.latitude, coordinate.longitude,
      pathHead: 'assets/');

// 获取ip地址
  final ipStr = await FlutterZLocation.getIp();
// 经纬度反向地理编码获取地址信息(省、市、区)
  final res2 = await FlutterZLocation.geocodeIp(ipStr, pathHead: 'assets/');
  print(coordinate);
  print(res1);
  print(ipStr);
  print(res2);
  return [res1.latitude, res1.longitude];
  // });
}
