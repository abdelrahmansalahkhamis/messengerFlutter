class FavouratesModel {
  bool status;
  Null message;
  Data data;

  FavouratesModel(
      {required this.status, required this.message, required this.data});

  factory FavouratesModel.fromJson(Map<String, dynamic> json) =>
      FavouratesModel(
          status: json['status'],
          message: json['message'],
          data: Data.fromJson(json['data']));
}

class Data {
  int currentPage;
  List<FavouratesData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;

  Data(
      {required this.currentPage,
      required this.data,
      required this.firstPageUrl,
      required this.from,
      required this.lastPage,
      required this.path,
      required this.perPage,
      required this.prevPageUrl,
      required this.to,
      required this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      currentPage: json['current_page'],
      data: List<FavouratesData>.from(
          json['data'].map((x) => FavouratesData.fromJson(x))),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total']);
}

class FavouratesData {
  int id;
  Product product;

  FavouratesData({required this.id, required this.product});

  factory FavouratesData.fromJson(Map<String, dynamic> json) => FavouratesData(
      id: json['id'], product: Product.fromJson(json['product']));
}

class Product {
  int id;
  dynamic price;
  dynamic oldPrice;
  int discount;
  String image;
  String name;
  String description;

  Product(
      {required this.id,
      required this.price,
      required this.oldPrice,
      required this.discount,
      required this.image,
      required this.name,
      required this.description});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description']);
}
