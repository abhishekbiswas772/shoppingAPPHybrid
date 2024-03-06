import 'dart:async';
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
    final List<Isolate> isolates = [];

    isolates.add(await Isolate.spawn(fetchProduct, productPort.sendPort));
    isolates.add(await Isolate.spawn(fetchCategory, categoryPort.sendPort));

    final productFuture = productPort.first;
    final categoryFuture = categoryPort.first;

    List<HomeAllProductModel>? productData;
    List<HomeCategoryModel>? categoryData;

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

    productPort.close();
    categoryPort.close();

    for (final isolate in isolates) {
      isolate.kill();
    }

    if (productData != null && categoryData != null) {
      HomeModel initHomeModel =
          HomeModel(allCategory: categoryData, allProductModel: productData);
      return initHomeModel;
    } else {
      return null;
    }
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
