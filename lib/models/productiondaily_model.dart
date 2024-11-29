// import 'dart:convert';

// // Converts a JSON string into a list of ItemModel
// List<ItemModel> itemModelFromJson(String str) =>
//     List<ItemModel>.from(json.decode(str).map((x) => ItemModel.fromJson(x)));

// // Converts a list of ItemModel into a JSON string
// String itemModelToJson(List<ItemModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// // Model for Item data
// class ItemModel {
//   String description;
//   String typeofValue;
//   bool standard;
//   String unitID;
//   dynamic stdMax;
//   dynamic stdMin;
//   String lineID;
//   String mcName;
//   String mcID;
//   int item;
//   String linename;
//   String LineID;
//   String LineName;

//   ItemModel({
//     required this.description,
//     required this.typeofValue,
//     required this.standard,
//     required this.unitID,
//     this.stdMax,
//     this.stdMin,
//     required this.lineID,
//     required this.mcName,
//     required this.mcID,
//     required this.item,
//     required this.linename,
//     required this.LineID,
//     required this.LineName,
//   });

//   // Creates an ItemModel instance from a JSON string
//   factory ItemModel.fromRawJson(String str) =>
//       ItemModel.fromJson(json.decode(str));

//   // Converts the ItemModel instance to a JSON string
//   String toRawJson() => json.encode(toJson());

//   // Creates an ItemModel instance from a Map
//   factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
//         description: json["Description"] ?? '',
//         typeofValue: json["TypeofValue"] ?? '',
//         standard: json["Standard"] ?? false,
//         unitID: json["UnitID"] ?? '',
//         stdMax: json["STDMax"],
//         stdMin: json["STDMin"],
//         lineID: json["LineID"] ?? '',
//         mcName: json["McName"] ?? '',
//         mcID: json["McID"] ?? '',
//         item: json["Item"],
//         linename: json["LineName"] ?? '',
//         LineID: json["LineID"] ?? '',
//         LineName: json["LineName"] ?? '',
//       );
//   // Converts the ItemModel instance to a Map
//   Map<String, dynamic> toJson() => {
//         "Description": description,
//         "TypeofValue": typeofValue,
//         "Standard": standard,
//         "UnitID": unitID,
//         "STDMax": stdMax,
//         "STDMin": stdMin,
//         "LineID": lineID,
//         "McName": mcName,
//         "McID": mcID,
//         "Item": item,
//         "LineName": linename,
//         "LineID": LineID,
//         "LineName": LineName,
//       };
// }
