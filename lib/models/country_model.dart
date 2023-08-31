import 'dart:convert';

class CountryModel {
  String? status;
  List<Country>? data;

  CountryModel({
    this.status,
    this.data,
  });

  factory CountryModel.fromRawJson(String str) =>
      CountryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Country>.from(json["data"]!.map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Country {
  String? name;

  Country({
    this.name,
  });

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": name,
      };
}
