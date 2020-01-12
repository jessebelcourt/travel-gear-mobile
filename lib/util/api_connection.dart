import 'dart:io';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:travel_gear_mobile/models/data_models/user_model.dart';

import 'package:travel_gear_mobile/util/api_routes.dart';

class ApiConnection {
  static final ApiConnection _api = ApiConnection.internal();
  String _token;
  bool guard = true;
  Dio dio;

  factory ApiConnection() {
    return _api;
  }

  ApiConnection.internal() {
    this.dio = Dio();
    _initTokenFromDevice();

    this.dio.options.baseUrl = baseApiUrl;

      // running on the web!
      //for self signed certificates (i.e. development)
      (this.dio.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (HttpClient client) {
        // create a `SecurityContext` instance to trust your certificate
        bool trustSelfSigned = true;
        HttpClient httpClient = new HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) =>
                  trustSelfSigned);

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

  void _initTokenFromDevice() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'travel_gear_access_token');

    if (token != null) {
      this.setToken(token);
    }
  }

  Future<bool> saveTokenToDevice(String token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'travel_gear_access_token', value: token);

    String tokenSet = await storage.read(key: 'travel_gear_access_token');
    this.setToken(tokenSet);
    return (tokenSet != null);
  }

  void setToken(String token) {
    this._token = token;
    this.dio.options.headers = {'Authorization': "Bearer $token"};
  }

  /// Check if there is a bearer token set on the device.
  ///
  /// Return [true] if token is saved on the device. [false] otherwise
  Future<bool> tokenIsSet() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'travel_gear_access_token');

    return (token != null);
  }

  Future<bool> validateToken(String token) async {
    bool valid = false;
    print('validateToken token: $token');

    try {
      Response response = await this.dio.post('/auth/validate-token', data: {
        'token': token,
      });

      print('validateToken: $token');

      if (response.data['access_token'] != null) {
        print("token: ${response.data['access_token']}");
        this.setToken(response.data['access_token']);
        this.saveTokenToDevice(response.data['access_token']);
        valid = true;
      } else {
        this.deleteToken();
      }
    } on DioError catch (e) {
      print("There was a problem validating the token (DioError): $e");
      print("${e.response.data}");
    } catch (e) {
      print('There was problem validating the token: $e');
    }

    return valid;
  }

  /// Checks whether the bearer token is valid through the Laravel API.
  ///
  /// Returns [true] if token is set in Header, and if it is still valid
  /// through Laravel backend. returns [false] otherwise.
  Future<Map<String, dynamic>> isTokenValid() async {
    Map<String, dynamic> data = {'valid': false};

    try {
      Response response = await this.dio.get('authenticated');

      print('isTokenValid: $response');
      data['valid'] = (response.data['valid'] == true);
      data['user'] =
          data['valid'] ? UserModel.fromJson(response.data['user']) : null;

    } catch (e) {
      print('there was an issue validating the token: $e');
    }

    return data;
  }

  void deleteToken() async {
    print('deleting token');
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'travel_gear_access_token');
    this.dio.options.headers = {'Authorization': "Bearer ''"};
    this._token = '';
  }

  /*============ Authorization Methods ==============*/

  Future<Map<String, dynamic>> attemptLogin(
      String email, String password, int appId) async {
    Map<String, dynamic> loginResponse = {
      "loggedIn": false,
    };

    try {
      Response response = await this.dio.post('appuser/login', data: {
        "email": email,
        "password": password,
        "app_id": appId,
      });

      print('attemptLogin response: $response');

      if (response.data['access_token'] != null &&
          response.data['user'] != null) {
        this.setToken(response.data['access_token']);
        this.saveTokenToDevice(response.data['access_token']);
        loginResponse['loggedIn'] = true;
        loginResponse['user'] = UserModel.fromJson(response.data['user']);
      } else if (response.data['message'] != null) {
        loginResponse['message'] = response.data['message'];
      }
    } catch (e) {
      print(e);
    }

    return loginResponse;
  }

  Future<bool> logout() async {
    try {
      Response response = await this.dio.post('appuser/logout');
      print('logout: $response');
    } catch (e) {
      print('There was a problem logging out: $e');
    }

    return true;
  }
}
