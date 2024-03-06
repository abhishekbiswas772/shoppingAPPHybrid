import 'dart:convert';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model_all.dart';
import 'package:bloc_example/Shopping/Home/HomeRepo/Constants/home_constants.dart';
import 'package:bloc_example/Utils/Api/calling_api_service.dart';

class DetailsRepo {
  final ApiGenericService apiService = ApiGenericService();
  Future<HomeAllProductModel?> getSingleModel(int id) async {
    final String singleCategoryModel =
        HomeConstants.singleProductURIBuilder(id);
    final responseString = await apiService.genricApiCall(
        singleCategoryModel, null, null, RepoHttpMethods.get);
    if (responseString != null) {
      Map<String, dynamic> responseObject = json.decode(responseString);
      HomeAllProductModel responseModel =
          HomeAllProductModel.fromJson(responseObject);
      return responseModel;
    } else {
      return null;
    }
  }
}
