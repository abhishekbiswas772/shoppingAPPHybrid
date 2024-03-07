class HomeConstants {
  static String baseURI = "https://fakestoreapi.com";
  static String bannerURI =
      "https://65e962b04bb72f0a9c51569c.mockapi.io/api/v1/data";
  static String productEndpoint = "/products";
  static String categoryEndpoint = "/categories";

  static String singleProductURIBuilder(int id) {
    String singleProductURL = "$baseURI$productEndpoint/$id";
    return singleProductURL;
  }

  static String singleCategoryURIBuilder(String category) {
    String singleCategoryURL = baseURI + categoryEndpoint + category;
    return singleCategoryURL;
  }
}
