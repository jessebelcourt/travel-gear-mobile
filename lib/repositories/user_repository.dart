import 'package:dio/dio.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:travel_gear_mobile/database/database_helper.dart';
import 'package:travel_gear_mobile/models/data_models/user_model.dart';
import 'package:travel_gear_mobile/util/api_connection.dart';

class UserRepository {
  static final ApiConnection api = ApiConnection();
  static DatabaseHelper databaseHelper = DatabaseHelper();

  static Future<Map<String, dynamic>> attemptLogin(
      Map<String, dynamic> loginData) async {
    Map<String, dynamic> loginResponse = {
      "token": null,
      "errors": [],
    };

    try {
      Response response =
          await UserRepository.api.dio.post('login', data: loginData);

      print('attemptLogin response: $response');

      if (response.data['access_token'] != null &&
          response.data['access_token'].isNotEmpty) {
        loginResponse['token'] = response.data['access_token'];
      }
    } on DioError catch(e) {
      print('There was a problem logging in: ${e.response.data}');
      loginResponse['errors'] = UserRepository.api.formatServerErrors(e);
    } 
    catch (e) {
      loginResponse['errors']
          .add("There was a problem, please try again later..");
    }

    return loginResponse;
  }

  static Future<Map<String, dynamic>> register(
      Map<String, dynamic> registerData) async {
    Map<String, dynamic> registerResponse = {
      "token": null,
      "errors": [],
    };

    try {
      Response response = await UserRepository.api.dio.post(
        'register',
        data: registerData,
      );

      if (response.data['access_token'] != null) {
        registerResponse['token'] = response.data['access_token'];
        UserRepository.api.token = registerResponse['token'];
      }
    } on DioError catch (e) {
      if (e.response.data['errors'] != null) {
        print('There was a problem during registration: ${e.response.data}');
        registerResponse['errors'] = UserRepository.api.formatServerErrors(e);
      }
    } catch (e) {
      print('There was a problem during registration: $e');
      registerResponse['errors']
          .add("There was a problem, please try again later..");
    }

    return registerResponse;
  }

  static Future<UserModel> localUser() async {
    Database db = await UserRepository.databaseHelper.database;
    UserModel user;

    List<Map<String, dynamic>> _inUsers = await db.query('user');

    if (_inUsers.isNotEmpty) {
      Map<String, dynamic> rawUserData = _inUsers[0];
      user = UserModel.fromLocalJson(rawUserData);
    } else {
      UserModel user = UserModel();
      user.localId = await db.insert('user', user.toMap());
    }

    return user;
  }

  // This checks the Bearer token saved locally on the device
  static Future<bool> tokenIsValid(String token) async {
    bool valid = false;
    try {
      api.token = token;
      Response response = await api.dio.get('/authenticated');
      print(response);
      valid = response.data['is_authenticated'] != null &&
          response.data['is_authenticated'];
    } on DioError catch (e) {
      print(
          'There was a problem checking the tokens validity (DioError): ${e.response.data}');
    } catch (e) {
      print('There was a problem checking the tokens validity: $e');
    }

    return valid;
  }

  static Future<UserModel> fetchLoggedInUsersData() async {
    UserModel user;

    try {
      Response response = await api.dio.get('/user/current');
      user = UserModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      print('There was a problem fetching the users data: ${e.response.data}');
    } catch (e) {
      print('There was a problem fetching the users data: $e');
    }

    return user;
  }

  static Future<bool> updateUserLocally(UserModel user) async {
    Database db = await UserRepository.databaseHelper.database;
    Map<String, dynamic> preUpdate = user.toMap();
    if (user.localId != null) {
      int numUpdated = await db.update(
        'user',
        preUpdate,
        where: 'local_id = ?',
        whereArgs: [user.localId],
      );

      return numUpdated > 0;
    }
    return false;
  }

  // Future<bool> logout() async {
  //   try {
  //     Response response = await this.dio.post('appuser/logout');
  //     print('logout: $response');
  //   } catch (e) {
  //     print('There was a problem logging out: $e');
  //   }

  //   return true;
  // }

  // void deleteToken() async {
  //   print('deleting token');
  //   final storage = new FlutterSecureStorage();
  //   await storage.delete(key: 'travel_gear_access_token');
  //   this.dio.options.headers = {'Authorization': "Bearer ''"};
  //   this._token = '';
  // }

  // /// Checks whether the bearer token is valid through the Laravel API.
  // ///
  // /// Returns [true] if token is set in Header, and if it is still valid
  // /// through Laravel backend. returns [false] otherwise.
  // Future<Map<String, dynamic>> isTokenValid() async {
  //   Map<String, dynamic> data = {'valid': false};

  //   try {
  //     Response response = await this.dio.get('authenticated');

  //     print('isTokenValid: $response');
  //     data['valid'] = (response.data['valid'] == true);
  //     data['user'] =
  //         data['valid'] ? UserModel.fromJson(response.data['user']) : null;

  //   } catch (e) {
  //     print('there was an issue validating the token: $e');
  //   }

  //   return data;
  // }

}
