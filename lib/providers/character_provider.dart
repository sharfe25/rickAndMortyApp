import 'dart:convert';

import 'package:rick_and_morty/models/character.dart';
import 'package:http/http.dart' as http;

class CharacterProvider {
  //Esta funcion trae todos los characters que brinda la api por paginacion
  Future<List<Character>> getAllCharacters(int page) async {
    final url = Uri.parse(
        "https://rickandmortyapi.com/api/character?page=" + "$page");
    final response = await http.get(url);

    final decodedData = json.decode(response.body);
    List<Character> characters = [];
    for (var character in decodedData["results"]) {
      characters.add(Character.fromJson(character));
    }
    return characters;
  }
}