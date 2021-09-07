// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

// CategoriesModel apiResponseFromJson(String str) =>
//     CategoriesModel.fromJson(json.decode(str));

// String apiResponseToJson(CategoriesModel data) => json.encode(data.toJson());

// class CategoriesModel {
// CategoriesModel({
//   required this.status,
//   this.message,
//   required this.data,
// });

//   bool status;
//   dynamic message;
//   DataModel data;

// factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
//     CategoriesModel(
//       status: json["status"],
//       message: json["message"],
//       data: DataModel.fromJson(json["data"]),
//     );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//       };
// }

// class DataModel {
//   DataModel({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });

//   int? currentPage;
//   List<CategoiesDataModel> data;
//   String firstPageUrl;
//   int? from;
//   int? lastPage;
//   String lastPageUrl;
//   dynamic nextPageUrl;
//   String path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;

// factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
//       currentPage: json["current_page"],
//       data: List<CategoiesDataModel>.from(
//           json["data"].map((x) => CategoiesDataModel.fromJson(x))),
//       firstPageUrl: json["first_page_url"],
//       from: json["from"],
//       lastPage: json["last_page"],
//       lastPageUrl: json["last_page_url"],
//       nextPageUrl: json["next_page_url"],
//       path: json["path"],
//       perPage: json["per_page"],
//       prevPageUrl: json["prev_page_url"],
//       to: json["to"],
//       total: json["total"],
//     );

//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//       };
// }

// class CategoiesDataModel {
//   CategoiesDataModel({
//     required this.id,
//     required this.name,
//     required this.image,
//   });

//   int? id;
//   String name;
//   String image;

// factory CategoiesDataModel.fromJson(Map<String, dynamic> json) =>
//     CategoiesDataModel(
//       id: json["id"],
//       name: json["name"],
//       image: json["image"],
//     );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "image": image,
//       };
// }

class CategoriesModel {
  bool status;
  DataModel data;

  CategoriesModel({
    required this.status,
    required this.data,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        status: json["status"],
        data: DataModel.fromJson(json["data"]),
      );
}

class DataModel {
  List<CategoriesDataModel> data;
  DataModel({required this.data});

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        data: List<CategoriesDataModel>.from(
            json["data"].map((x) => CategoriesDataModel.fromJson(x))),
      );
}

class CategoriesDataModel {
  //int id;
  String image;
  String name;

  CategoriesDataModel({required this.name, required this.image});

  factory CategoriesDataModel.fromJson(Map<String, dynamic> json) =>
      CategoriesDataModel(
        //id: json["id"],
        name: json["name"],
        image: json["image"],
      );
}
