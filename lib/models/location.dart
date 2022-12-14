// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
    Location({
        this.id = 0,
        required this.name,
        this.type = "",
        this.dimension = "",
        this.residents,
        required this.url,
        this.created,
    });

    int id;
    String name;
    String type;
    String dimension;
    List<String>? residents;
    String url;
    DateTime? created;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"] ?? 0,
        name: json["name"],
        type: json["type"] ?? "",
        dimension: json["dimension"] ?? "",
        residents: json["residents"] != null? List<String>.from(json["residents"].map((x) => x)) : null,
        url: json["url"],
        created: json["created"] != null? DateTime.parse(json["created"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": residents != null ? List<dynamic>.from(residents!.map((x) => x)) : null,
        "url": url,
        "created": created != null ? created!.toIso8601String() : null,
    };
}
