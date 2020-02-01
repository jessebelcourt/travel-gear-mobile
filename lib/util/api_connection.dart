import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:travel_gear_mobile/util/api_routes.dart';

class ApiConnection {
  static final ApiConnection _api = ApiConnection.internal();
  Dio dio;

  factory ApiConnection() {
    return _api;
  }

  ApiConnection.internal() {
    this.dio = Dio();
    this.dio.options.baseUrl = baseApiUrl;

    // running on the web!
    //for self signed certificates (i.e. development)
    (this.dio.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate = (HttpClient client) {
      // create a `SecurityContext` instance to trust your certificate
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);

      return httpClient;
    };

    this.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          // Do something before request is sent
          options.headers['Accept'] = 'application/json';
          return options; //continue
        },
      ),
    );
  }

  void setToken(String token) {
    this.dio.options.headers = {'Authorization': "Bearer $token"};
  }

  List<String> formatServerErrors(DioError e) {
    Map<String, dynamic> errorMap = e.response.data['errors'];
    return errorMap.values.map((error) => error[0]).toList().cast<String>();
  }
}
