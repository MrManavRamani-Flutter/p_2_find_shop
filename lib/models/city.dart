class City {
  final int cityId;
  String cityName;

  City({required this.cityId, required this.cityName});

  // Method to update the city name
  void updateCityName(String newName) {
    cityName = newName;
  }
}
