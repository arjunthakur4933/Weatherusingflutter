import 'package:flutter/material.dart';

import '../../../data/repository/api_repository.dart';
import '../../../data/repository/store_repository.dart';
import '../../../model/city.dart';
import '../../common/debouncer.dart';

class AddCityBloc extends ChangeNotifier {
  final debouncer = Debouncer();
  final StoreRepository storage;
  final ApiRepository apiService;
  List<City> cities = [];
  bool loading = false;
  String? errorMessage;

  AddCityBloc({
    required this.storage,
    required this.apiService,
  }) : errorMessage = ''; // Initializing the errorMessage field to an empty string

  void onChangedText(String text) {
    debouncer.run(
      () {
        if (text.isNotEmpty) requestSearch(text);
      },
    );
  }

  void requestSearch(String text) async {
    loading = true;
    notifyListeners();

    cities = await apiService.getCities(text);

    loading = false;
    notifyListeners();
  }

  Future<bool> addCity(City city) async {
    loading = true;
    notifyListeners();

    final newCity = await apiService.getWeathers(city);

    try {
      await storage.saveCity(newCity);
      errorMessage = null; // No error occurred, so set errorMessage to null
      loading = false;
      notifyListeners();
      return true;
    } catch (ex) {
      print(ex.toString());
      errorMessage = ex.toString(); // Assign the error message
      loading = false;
      notifyListeners();
      return false;
    }
  }

}
