


import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/repository/store_repository.dart';
import '../../model/city.dart';
import '../../model/weather.dart';

const String keyCities = 'cities';
const String keyLastUpdate = 'last_update';

class StoreImpl extends StoreRepository {
  @override
  Future<List<City>> getCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? list = prefs.getStringList(keyCities);
    if (list != null && list.isNotEmpty) {
      final List<City> cities = list.map((e) => City.fromJson(jsonDecode(e))).toList();
      return cities;
    }
    return <City>[];
  }

  @override
  Future<void> saveCity(City city) async {
    final List<City> list = await getCities();
    for (City item in list) {
      if (item.id == city.id) {
        throw Exception('The city already exists');
      }
    }
    list.add(city);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      keyCities,
      list.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  @override
  Future<void> saveCities(List<City> cities) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      keyCities,
      cities.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  @override
  Future<DateTime> getLastUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? data = prefs.getInt(keyLastUpdate);

    if (data != null && data > 0) {
      return DateTime.fromMillisecondsSinceEpoch(data);
    }

    // If data is null or not > 0, return a default value, e.g., epoch time
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  @override
  Future<void> saveLastUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyLastUpdate, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<void> deleteCity(City city) async {
    List<City> cities = await getCities();
    cities.removeWhere((element) => element.id == city.id);
    await saveCities(cities);
  }
}
