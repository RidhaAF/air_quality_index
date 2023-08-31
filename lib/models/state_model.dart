import 'dart:convert';

class StateModel {
  String? status;
  List<StateData>? data;

  StateModel({
    this.status,
    this.data,
  });

  factory StateModel.fromRawJson(String str) =>
      StateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<StateData>.from(
                json["data"]!.map((x) => StateData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class StateData {
  String? name;

  StateData({
    this.name,
  });

  factory StateData.fromRawJson(String str) =>
      StateData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StateData.fromJson(Map<String, dynamic> json) => StateData(
        name: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "state": name,
      };
}
