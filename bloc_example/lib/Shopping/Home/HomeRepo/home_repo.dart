import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:bloc_example/Shopping/Home/HomeModel/home_category_model.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model_all.dart';
import 'package:bloc_example/Shopping/Home/HomeRepo/Constants/home_constants.dart';
import 'package:http/http.dart' as http;

class HomeRepo {
  Future<HomeModel?> getProductAndCategory() async {
    final ReceivePort productPort = ReceivePort();
    final ReceivePort categoryPort = ReceivePort();
    final ReceivePort bannerPort = ReceivePort();
    final List<Isolate> isolates = [];

    isolates.add(await Isolate.spawn(fetchProduct, productPort.sendPort));
    isolates.add(await Isolate.spawn(fetchCategory, categoryPort.sendPort));
    isolates.add(await Isolate.spawn(fetchBanner, bannerPort.sendPort));

    final productFuture = productPort.first;
    final categoryFuture = categoryPort.first;
    final bannerFuture = bannerPort.first;

    List<HomeAllProductModel>? productData;
    List<HomeCategoryModel>? categoryData;
    List<HomeBanner>? bannerData;

    try {
      productData = await productFuture as List<HomeAllProductModel>?;
    } catch (e) {
      print('Error fetching product: $e');
    }

    try {
      categoryData = await categoryFuture as List<HomeCategoryModel>?;
    } catch (e) {
      print('Error fetching category: $e');
    }

    try {
      bannerData = await bannerFuture as List<HomeBanner>?;
    } catch (e) {
      print('Error fetching category: $e');
    }

    productPort.close();
    categoryPort.close();
    bannerPort.close();

    for (final isolate in isolates) {
      isolate.kill();
    }

    if (productData != null && categoryData != null && bannerData != null) {
      HomeModel initHomeModel = HomeModel(
          allCategory: categoryData,
          allProductModel: productData,
          bannerList: bannerData);
      return initHomeModel;
    } else {
      return null;
    }
  }
}

void fetchBanner(SendPort sendPort) async {
  final String bannerURI = HomeConstants.bannerURI;
  final http.Response response = await http.get(Uri.parse(bannerURI));
  if (response.statusCode == 200) {
    List<HomeBanner> bannerListCreated = [];
    List<dynamic> bannerArray = json.decode(response.body);
    for (var item in bannerArray) {
      String title = item["title"] as String;
      String mobileStringImage = item["imageMobile"] as String;
      HomeBanner homeBanner =
          HomeBanner(title: title, mobileImageBanner: mobileStringImage);
      bannerListCreated.add(homeBanner);
    }
    sendPort.send(bannerListCreated);
  } else {
    sendPort.send(null);
  }
}

void fetchProduct(SendPort sendPort) async {
  final String allProductURIfinal =
      HomeConstants.baseURI + HomeConstants.productEndpoint;
  final http.Response response = await http.get(Uri.parse(allProductURIfinal));
  if (response.statusCode == 200) {
    List<HomeAllProductModel> allProductModels =
        HomeAllProductModel.parseProducts(response.body);
    sendPort.send(allProductModels);
  } else {
    sendPort.send(null);
  }
}

void fetchCategory(SendPort sendPort) async {
  final String allCategoryURIFinal = HomeConstants.baseURI +
      HomeConstants.productEndpoint +
      HomeConstants.categoryEndpoint;
  print(allCategoryURIFinal);
  final http.Response response = await http.get(Uri.parse(allCategoryURIFinal));

  if (response.statusCode == 200) {
    List<HomeCategoryModel> allCategoryModels =
        HomeCategoryModel.parseProducts(response.body);
    sendPort.send(allCategoryModels);
  } else {
    sendPort.send(null);
  }
}
