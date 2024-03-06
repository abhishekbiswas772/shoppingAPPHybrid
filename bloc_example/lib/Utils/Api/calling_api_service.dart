import 'package:http/http.dart' as http;

enum RepoHttpMethods { get, post, put, delete }

class ApiGenericService {
  ApiGenericService._privateConstructor();
  static final ApiGenericService _instance = ApiGenericService._privateConstructor();
  factory ApiGenericService() {
    return _instance;
  }

  Future<String?> genricApiCall(String url, Map<String, String>? homeBody,
      Map<String, String>? homeHeaders, RepoHttpMethods method) async {
    http.Response? response;
    switch (method) {
      case RepoHttpMethods.get:
        response = await http.get(Uri.parse(url));
        break;
      case RepoHttpMethods.post:
        if (homeHeaders != null) {
          response = await http.post(Uri.parse(url),
              headers: homeHeaders, body: homeBody);
        } else {
          return null;
        }
        break;
      case RepoHttpMethods.put:
        if (homeHeaders != null) {
          response = await http.put(Uri.parse(url),
              headers: homeHeaders, body: homeBody);
        } else {
          return null;
        }
        break;
      case RepoHttpMethods.delete:
        response = await http.delete(Uri.parse(url),
            headers: homeHeaders, body: homeBody);
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
}

