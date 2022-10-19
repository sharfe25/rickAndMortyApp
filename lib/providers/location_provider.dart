import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/location.dart';

class LocationProvider {
  //Esta funcion trae todos las locaciones que brinda la api por paginacion
  Future<List<Location>> getAllLocations(int page) async {
    final url = Uri.parse(
        "https://rickandmortyapi.com/api/location?page=$page");
    final response = await http.get(url);

    final decodedData = json.decode(response.body);
    List<Location> locations = [];
    for (var location in decodedData["results"]) {
      locations.add(Location.fromJson(location));
    }
    return locations;
  }
}