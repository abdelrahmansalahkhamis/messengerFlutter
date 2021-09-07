import 'dart:convert';

// class HomeModel {
//   late bool status;
//   late HomeDataModel data;

//   HomeModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     // data = (json['data'] != null ? HomeDataModel.fromJson(json['data']) : null)!;
//     data = json['data'];
//   }
// }

// class HomeDataModel {
//   List<BannerModel> banners = [];
//   List<ProducrsModel> products = [];

//   HomeDataModel.fromJson(Map<String, dynamic> json) {
//     json['banners'].forEach((element) {
//       banners.add(element);
//     });
//     json['products'].forEach((element) {
//       products.add(element);
//     });
//   }
// }

// class BannerModel {
//   late int id;
//   late String image;
//   late String category;
//   late String product;
//   BannerModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//     category = json['category'];
//     product = json['product'];
//   }
// }

// class ProducrsModel {
//   late int id;
//   late dynamic price;
//   late dynamic old_price;
//   late dynamic discount;
//   late String image;
//   late String name;
//   late bool inFavourate;
//   late bool inCart;
//   ProducrsModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     old_price = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     inFavourate = json['in_favourate'];
//     inCart = json['in_cart'];
//   }
// }

///////////////////////////////////////////////////////////////////////////////

// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

HomeModel apiResponseFromJson(String str) =>
    HomeModel.fromJson(json.decode(str));

String apiResponseToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    required this.status,
    this.message,
    required this.data,
  });

  bool status;
  dynamic message;
  HomeModelData data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        message: json["message"],
        data: HomeModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class HomeModelData {
  HomeModelData({
    required this.banners,
    required this.products,
    required this.ad,
  });

  List<Banner> banners;
  List<Product> products;
  String ad;

  factory HomeModelData.fromJson(Map<String, dynamic> json) => HomeModelData(
        banners:
            List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        ad: json["ad"],
      );

  Map<String, dynamic> toJson() => {
        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "ad": ad,
      };
}

class Banner {
  Banner({
    required this.id,
    required this.image,
    this.category,
    this.product,
  });

  int id;
  String image;
  dynamic category;
  dynamic product;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["id"],
        image: json["image"],
        category: json["category"],
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "category": category,
        "product": product,
      };
}

class Product {
  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });

  int id;
  double price;
  double oldPrice;
  int discount;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"].toDouble(),
        oldPrice: json["old_price"].toDouble(),
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        inFavorites: json["in_favorites"],
        inCart: json["in_cart"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
        "name": name,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "in_favorites": inFavorites,
        "in_cart": inCart,
      };
}
