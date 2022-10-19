import 'dart:convert';

import 'package:rick_and_morty/models/location.dart';

Character characterFromJson(String str) => Character.fromJson(json.decode(str));

String characterToJson(Character data) => json.encode(data.toJson());

class Character {
    Character({
        required this.id,
        required this.name,
        required this.status,
        required this.species,
        required this.type,
        required this.gender,
        required this.origin,
        required this.location,
        required this.image,
        required this.episode,
        required this.url,
        required this.created,
    });

    int id;
    String name;
    String status;
    String species;
    String type;
    String gender;
    Location origin;
    Location location;
    String image;
    List<String> episode;
    String url;
    DateTime created;

    factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin: Location.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
    };
}


