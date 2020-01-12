class UserModel {
  int id;
  String name;//last_name
  String email; //email
  String profilePic; //community_avatar
  String bio; //description

  UserModel({
    this.id,
    this.name,
    this.email,
    this.profilePic,
    this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        profilePic = json['profile_pic'],
        bio = json['bio'];

  String toString() => '''
    ID            $id,
    name:         $name,
    email:        $email,
    profilePic:   $profilePic,
    bio:          $bio,
    ''';
}
