// class ChangeProductsModel {
// bool status;
// String message;
//   ChangeProductsModel({required this.status, required this.message});
//   factory ChangeProductsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//   }
// }

class ChangeFavouratesModel {
  bool status;
  String message;

  ChangeFavouratesModel({
    required this.status,
    required this.message,
  });

  factory ChangeFavouratesModel.fromJson(Map<String, dynamic> json) =>
      ChangeFavouratesModel(
        status: json["status"],
        message: json["data"],
      );
}
