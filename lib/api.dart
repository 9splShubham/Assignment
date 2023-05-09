import 'package:http/http.dart' as http;

class ApiProvider {
  static final ApiProvider _singletonApiProvider = ApiProvider._internal();

  factory ApiProvider() {
    return _singletonApiProvider;
  }

  ApiProvider._internal();
  Future getMethod(String apiUrl) async {
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');

    return response.body;
  }

  Future getCart(String apiUrl) async {
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');

    return response.body;
  }

/*
  Future postMethod(String apiUrl) async {
    var url = Uri.parse(apiUrl);
    var response = await http.post(url);
    print('Response status: ${response.statusCode}');

    return response.body;
  }*/
}
