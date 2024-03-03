// import 'package:weather/model/weather.dart';
// // import 'package:weatherflut/model/weather.dart';
//
// class City {
//   final String title;
//   final int id;
//   final List<Weather> weathers;
//
//   City({
//     required this.title,
//     required this.id,
//     required this.weathers,
//   });
//
//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "woeid": id,
//         "weathers": weathers.map((e) => e.toJson()).toList(),
//       };
//
//   factory City.fromJson(Map<String, dynamic> map) {
//     final myWeathers = map['weathers'];
//     return City(
//       id: map['woeid'],
//       title: map['title'],
//       weathers: myWeathers != null
//           ? (myWeathers as List).map((e) => Weather.fromJson(e)).toList()
//           : [], // Provide an empty list as a default value
//     );
//   }
//
//
//   City fromWeathers(List<Weather> weathers) {
//     return City(
//       id: id,
//       title: title,
//       weathers: weathers,
//     );
//   }
// }

import 'dart:convert';
import 'weather.dart'; // Assuming Weather model is in weather.dart

class City {
  final int id;
  final String name;
  final Coord coord;
  final List<Weather> weather;
  final Main main;
  final Wind wind;
  final Clouds clouds;
  final int visibility;
  final int dt;
  final Sys sys;
  final int timezone;
  final int cod;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.weather,
    required this.main,
    required this.wind,
    required this.clouds,
    required this.visibility,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.cod,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(json['coord']),
      weather: (json['weather'] as List)
          .map((weatherJson) => Weather.fromJson(weatherJson))
          .toList(),
      main: Main.fromJson(json['main']),
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      visibility: json['visibility'],
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      cod: json['cod'],
    );
  }
}

class Coord {
  final double lon;
  final double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'],
      lat: json['lat'],
    );
  }
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}

class Wind {
  final double speed;
  final int deg;

  Wind({
    required this.speed,
    required this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'],
      deg: json['deg'],
    );
  }
}

class Clouds {
  final int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}

