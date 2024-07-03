class UserLoginInfoModel{
  final String accessToken;

  UserLoginInfoModel({required this.accessToken});
  factory UserLoginInfoModel.formJson(Map<String,dynamic>json){
    return UserLoginInfoModel(
        accessToken: json["accesstoken"] as String
    );
  }
}

class UserModel{
  final int user_id;
  final String user_name;
  final String user_email;
  final String? user_contact;
  final String? user_bio ;
  final String? user_picture;
  final int? user_budget;
  final String user_location;
  UserModel(
      {
        required this.user_id,
        required this.user_name,
        required this.user_email,
        this.user_contact,
        this.user_bio,
        this.user_picture,
        this.user_budget,
        required this.user_location
      });
  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
        user_id: json["user_id"] as int,
        user_name: json["user_name"] as String,
        user_email: json["user_email"] as String,
        user_contact: json["user_contact"] as String?,
        user_bio: json["user_bio"] as String?,
        user_picture: json["user_picture"] as String?,
        user_budget: json["user_budget"] as int?,
        user_location: json["user_location"]
    );
  }
}