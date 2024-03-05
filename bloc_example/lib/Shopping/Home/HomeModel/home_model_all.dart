import 'dart:convert';

class HomeAllProductModel {
  int id;
  String title;
  double price;
  String category;
  String images;
  String description;
  Map<String, double> rating;

  HomeAllProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.images,
    required this.description,
    required this.rating
  });
  
  factory HomeAllProductModel.fromJson(Map<String, dynamic> json) {
    return HomeAllProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      images: json['image'],
      rating: {
        'rate': json['rating']['rate'].toDouble(),
        'count': json['rating']['count'].toDouble(),
      },
    );
  }

  static List<HomeAllProductModel> parseProducts(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<HomeAllProductModel>((json) => HomeAllProductModel.fromJson(json))
        .toList();
  }

}