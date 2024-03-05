import 'dart:async';
import 'dart:isolate';
import 'package:bloc_example/Shopping/Home/HomeModel/home_category_model.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model_all.dart';
import 'package:bloc_example/Shopping/Home/HomeRepo/Constants/home_constants.dart';
import 'package:http/http.dart' as http;

enum HomeRepoHttpMethods {
  get,
  post,
  put, 
  delete
}

class HomeRepo {

  Future<String?> genricApiCall(String url, Map<String, String>? homeBody, Map<String, String>? homeHeaders, HomeRepoHttpMethods method) async {
    http.Response? response;
    switch (method) {
      case HomeRepoHttpMethods.get:
        response = await http.get(Uri.parse(url));
        break;
      case HomeRepoHttpMethods.post:
        if (homeHeaders != null) {
          response = await http.post(Uri.parse(url), headers: homeHeaders, body: homeBody);
        } else {
          return null;
        }
        break;
      case HomeRepoHttpMethods.put:
        if (homeHeaders != null) {
          response = await http.put(Uri.parse(url), headers: homeHeaders, body: homeBody);
        } else {
          return null;
        }
        break;
      case HomeRepoHttpMethods.delete:
        response = await http.delete(Uri.parse(url), headers: homeHeaders, body: homeBody);
        break;
    }
    
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } else {
      return null;
    }
  }

  Future<HomeModel?> getProductAndCategory() async {
    final ReceivePort productPort = ReceivePort();
    final ReceivePort categoryPort = ReceivePort();
    final List<Isolate> isolates = [];
    isolates.add(await Isolate.spawn(fetchProduct, productPort.sendPort));
    isolates.add(await Isolate.spawn(fetchCategory, categoryPort.sendPort));
    final productFuture = productPort.first;
    final categoryFuture = categoryPort.first;
    final productData = await productFuture;
    final categoryData = await categoryFuture;
    productPort.close();
    categoryPort.close();
    for (final isolate in isolates) {
      isolate.kill();
    }
    if (productData != null && categoryData != null) {
      HomeModel initHomeModel = HomeModel(allCategory: categoryData, allProductModel: productData);
      return initHomeModel;
    } else {
      return null;
    }
  }
}

void fetchProduct(SendPort sendPort) async {
  final String allProductURIfinal = HomeConstants.baseURI + HomeConstants.productEndpoint;
  final http.Response response = await http.get(Uri.parse(allProductURIfinal));
  if (response.statusCode == 200) {
    List<HomeAllProductModel> allProductModels = HomeAllProductModel.parseProducts(response.body);
    sendPort.send(allProductModels);
  } else {
    sendPort.send(null);
  }
}

void fetchCategory(SendPort sendPort) async {
  final String allCategoryURIFinal = HomeConstants.baseURI + HomeConstants.categoryEndpoint;
  final http.Response response = await http.get(Uri.parse(allCategoryURIFinal));

  if (response.statusCode == 200) {
    List<HomeCategoryModel> allCategoryModels = HomeCategoryModel.parseProducts(response.body);
    sendPort.send(allCategoryModels);
  } else {
    sendPort.send(null);
  }
}
