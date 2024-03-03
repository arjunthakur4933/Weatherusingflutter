



import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/city.dart';
import '../../model/weather.dart';
import 'api_repository.dart';
//import 'package:weather/model/weather.dart';


class ApiImpl extends ApiRepository {
  static const String api = 'YOUR_API_ENDPOINT_HERE'; // Replace this with your API endpoint

  @override
  Future<List<City>> getCities(String text) async {
    final url = '$api/search/?query=$text';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<City> cities = data.map((e) => City.fromJson(e)).toList();
      return cities;
    } else {
      throw Exception('Failed to load cities');
    }
  }

  @override
  Future<City> getWeathers(City city) async {
    final url = '$api/${city.id}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      final List<dynamic> weatherData = data['consolidated_weather'];
      final List<Weather> weathers = weatherData.map((e) => Weather.fromJson(e)).toList();
      final newCity = city.fromWeathers(weathers);
      return newCity;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
