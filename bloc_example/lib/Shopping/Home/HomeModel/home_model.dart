import 'package:bloc_example/Shopping/Home/HomeModel/home_category_model.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model_all.dart';

class HomeModel {
  List<HomeCategoryModel> allCategory;
  List<HomeAllProductModel> allProductModel;
  HomeModel({required this.allCategory, required this.allProductModel});
}