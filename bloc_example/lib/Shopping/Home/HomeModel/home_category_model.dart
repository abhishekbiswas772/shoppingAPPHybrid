import 'dart:convert';

class HomeCategoryModel {
  String categoryName;

  HomeCategoryModel({
    required this.categoryName,
  });

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    return HomeCategoryModel(
      categoryName: json['categoryName'],
    );
  }

  static List<HomeCategoryModel> parseProducts(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<HomeCategoryModel>((json) => HomeCategoryModel.fromJson(json))
        .toList();
  }
}
