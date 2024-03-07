import 'package:bloc_example/Shopping/Home/HomeModel/home_category_model.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model_all.dart';

class HomeModel {
  List<HomeCategoryModel> allCategory;
  List<HomeAllProductModel> allProductModel;
  List<HomeBanner> bannerList;
  HomeModel(
      {required this.allCategory,
      required this.allProductModel,
      required this.bannerList});
}

class HomeBanner {
  String title;
  String mobileImageBanner;
  HomeBanner({required this.title, required this.mobileImageBanner});
}
