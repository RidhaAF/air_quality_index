import 'dart:convert';

class AqiModel {
  String? status;
  AqiData? data;

  AqiModel({
    this.status,
    this.data,
  });

  factory AqiModel.fromRawJson(String str) =>
      AqiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AqiModel.fromJson(Map<String, dynamic> json) => AqiModel(
        status: json["status"],
        data: json["data"] == null ? null : AqiData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class AqiData {
  String? city;
  String? state;
  String? country;
  Location? location;
  Current? current;

  AqiData({
    this.city,
    this.state,
    this.country,
    this.location,
    this.current,
  });

  factory AqiData.fromRawJson(String str) => AqiData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AqiData.fromJson(Map<String, dynamic> json) => AqiData(
        city: json["city"],
        state: json["state"],
        country: json["country"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        current:
            json["current"] == null ? null : Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
        "location": location?.toJson(),
        "current": current?.toJson(),
      };
}

class Current {
  Pollution? pollution;
  Weather? weather;

  Current({
    this.pollution,
    this.weather,
  });

  factory Current.fromRawJson(String str) => Current.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        pollution: json["pollution"] == null
            ? null
            : Pollution.fromJson(json["pollution"]),
        weather:
            json["weather"] == null ? null : Weather.fromJson(json["weather"]),
      );

  Map<String, dynamic> toJson() => {
        "pollution": pollution?.toJson(),
        "weather": weather?.toJson(),
      };
}

class Pollution {
  DateTime? ts;
  int? aqius;
  String? mainus;
  int? aqicn;
  String? maincn;

  Pollution({
    this.ts,
    this.aqius,
    this.mainus,
    this.aqicn,
    this.maincn,
  });

  factory Pollution.fromRawJson(String str) =>
      Pollution.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pollution.fromJson(Map<String, dynamic> json) => Pollution(
        ts: json["ts"] == null ? null : DateTime.parse(json["ts"]),
        aqius: json["aqius"],
        mainus: json["mainus"],
        aqicn: json["aqicn"],
        maincn: json["maincn"],
      );

  Map<String, dynamic> toJson() => {
        "ts": ts?.toIso8601String(),
        "aqius": aqius,
        "mainus": mainus,
        "aqicn": aqicn,
        "maincn": maincn,
      };
}

class Weather {
  DateTime? ts;
  int? tp;
  int? pr;
  int? hu;
  double? ws;
  int? wd;
  String? ic;

  Weather({
    this.ts,
    this.tp,
    this.pr,
    this.hu,
    this.ws,
    this.wd,
    this.ic,
  });

  factory Weather.fromRawJson(String str) => Weather.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        ts: json["ts"] == null ? null : DateTime.parse(json["ts"]),
        tp: json["tp"],
        pr: json["pr"],
        hu: json["hu"],
        ws: json["ws"]?.toDouble(),
        wd: json["wd"],
        ic: json["ic"],
      );

  Map<String, dynamic> toJson() => {
        "ts": ts?.toIso8601String(),
        "tp": tp,
        "pr": pr,
        "hu": hu,
        "ws": ws,
        "wd": wd,
        "ic": ic,
      };
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
