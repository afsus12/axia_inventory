import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.protmUser,
    this.decode,
  });

  String protmUser;
  String decode;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        protmUser: json["protmUser"],
        decode: json["decode"],
      );

  Map<String, dynamic> toJson() => {
        "name": protmUser,
        "decode": decode,
      };
}
