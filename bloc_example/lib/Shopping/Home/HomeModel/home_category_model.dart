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
  List<dynamic> responseParsed = jsonDecode(responseBody);
  List<HomeCategoryModel> catModel = [];

  for (var item in responseParsed) {
    if (item is String) {
      HomeCategoryModel singleModel = HomeCategoryModel(categoryName: item);
      catModel.add(singleModel);
    } else {
      HomeCategoryModel singleModel = HomeCategoryModel(categoryName: item.toString());
      catModel.add(singleModel);
    }
  }

  return catModel;
}
}
