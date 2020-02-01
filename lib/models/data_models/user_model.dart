import 'package:travel_gear_mobile/repositories/user_repository.dart';

class UserModel {
  int remoteId;
  int localId;
  String name;
  String email;
  String profilePic;
  String bio;
  String token;

  UserModel({
    this.remoteId,
    this.localId,
    this.name,
    this.email,
    this.profilePic,
    this.bio,
    this.token,
  });

  /// Data coming from json returned from device local db
  UserModel.fromLocalJson(Map<String, dynamic> json)
      : localId = json['local_id'],
        remoteId = json['remote_id'],
        name = json['name'],
        email = json['email'],
        profilePic = json['profile_pic'],
        bio = json['bio'],
        token = json['token'];

  /// Data coming from json returned from remote db
  UserModel.fromJson(Map<String, dynamic> json)
      : remoteId = json['id'],
        name = json['name'],
        email = json['email'],
        profilePic = json['profile_pic'],
        bio = json['bio'];

  // For local DB
  Map<String, dynamic> toMap() {
    return {
      'local_id': localId,
      'remote_id': remoteId,
      'name': name,
      'email': email,
      'profile_pic': profilePic,
      'bio': bio,
      'token': token,
    };
  }

  void updateFrom(UserModel user) {
    this.remoteId = user.remoteId;
    this.name = user.name;
    this.email = user.email;
    this.profilePic = user.profilePic;
    this.bio = user.bio;
    this.token = user.token;
  }

  String toString() => '''
    
    remoteId    $remoteId,
    localId:    $localId,
    name:       $name,
    email:      $email,
    profilePic: $profilePic,
    bio:        $bio,
    token:      $token
    ''';

  /*======= API ==========*/

  Future<Map<String, dynamic>> register(
      Map<String, dynamic> registerData) async {
    Map<String, dynamic> registerResponse =
        await UserRepository.register(registerData);

    // Save token to local db
    if (registerResponse['token'] != null &&
        registerResponse['token'].isNotEmpty) {
      this.token = registerResponse['token'];
      await this.update();
    }

    return registerResponse;
  }

  Future<Map<String, dynamic>> login(
      Map<String, dynamic> loginData) async {
    Map<String, dynamic> loginResponse =
        await UserRepository.attemptLogin(loginData);

    // Save token to local db
    if (loginResponse['token'] != null &&
        loginResponse['token'].isNotEmpty) {
      this.token = loginResponse['token'];
      await this.update();
    }

    return loginResponse;
  }

  static Future<UserModel> get userFromLocal async {
    return await UserRepository.localUser();
  }

  // This checks the Bearer token saved locally on the device
  Future<bool> get tokenIsValid async {
    bool valid = false;
    if (this.token != null &&
        this.token.isNotEmpty &&
        await UserRepository.tokenIsValid(this.token)) {
        valid = true;
    } else {
      this.token = null;
      this.update();
    }

    return valid;
  }

  Future<UserModel> fetchData() async {
    UserModel user = await UserRepository.fetchLoggedInUsersData();
    if (user != null) {
      this.updateFrom(user);
      this.update();
    }
    return user;
  }

  // Updates local db with model properties
  Future<bool> update() async => await UserRepository.updateUserLocally(this);
}
