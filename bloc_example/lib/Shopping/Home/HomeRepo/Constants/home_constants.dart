class HomeConstants {
  static String baseURI = "https://fakestoreapi.com";
  static String productEndpoint = "/products";
  static String categoryEndpoint = "categories";

  static String singleProductURIBuilder(int id){
    String singleProductURL = "$baseURI$productEndpoint/$id";
    return singleProductURL;
  }

  static String singleCategoryURIBuilder(String category){
    String singleCategoryURL = baseURI + categoryEndpoint + category;
    return singleCategoryURL;
  }
}