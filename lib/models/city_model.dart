import 'dart:convert';

class CityModel {
  String? status;
  List<City>? data;

  CityModel({
    this.status,
    this.data,
  });

  factory CityModel.fromRawJson(String str) =>
      CityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<City>.from(json["data"]!.map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class City {
  String? name;

  City({
    this.name,
  });

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "city": name,
      };
}
