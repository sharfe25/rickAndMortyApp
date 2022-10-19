import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models/episode.dart';

class EpisodeProvider {
  //Esta funcion trae todos los episodios que brinda la api por paginacion
  Future<List<Episode>> getAllEpisodes(int page) async {
    final url = Uri.parse(
        "https://rickandmortyapi.com/api/episode?page=$page");
    final response = await http.get(url);

    final decodedData = json.decode(response.body);
    List<Episode> episodes = [];
    for (var location in decodedData["results"]) {
      episodes.add(Episode.fromJson(location));
    }
    return episodes;
  }
}
