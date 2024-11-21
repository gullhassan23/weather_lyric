import 'dart:convert';

import 'package:dayglow/Models/GeoModel.dart';
import 'package:dayglow/Models/SunModel.dart';
import 'package:dayglow/Models/WeatherModel.dart';
import 'package:http/http.dart' as https;

class Apiservice {
  String id = "a47f2ca46f0c74e1a4dccacb73c310db";
  Future<GeoModel?> geoModel(String city) async {
    try {
      var response = await https.get(Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=$city&count=5'));

      if (response.statusCode == 200) {
        print(response.body.toString());
        GeoModel geoModel = GeoModel.fromJson(json.decode(response.body));
        return geoModel;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<SunModel?> sunModel(double lng, double lat) async {
    try {
      var response = await https.get(
          Uri.parse('https://api.sunrise-sunset.org/json?lat=$lat&lng=$lng'));

      if (response.statusCode == 200) {
        print(response.body.toString());
        SunModel sunModel = SunModel.fromJson(json.decode(response.body));
        return sunModel;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<WeatherModel?> weatherModel(double lng, double lat) async {
    try {
      var response = await https.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&appid=$id'));

      if (response.statusCode == 200) {
        print(response.body.toString());
        WeatherModel weatherModel =
            WeatherModel.fromJson(json.decode(response.body));
        print("temperature data ${weatherModel.main?.temp}");
        return weatherModel;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
