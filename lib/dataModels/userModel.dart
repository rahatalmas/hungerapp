class UserLoginInfoModel{
  final String accessToken;

  UserLoginInfoModel({required this.accessToken});
  factory UserLoginInfoModel.formJson(Map<String,dynamic>json){
    return UserLoginInfoModel(
        accessToken: json["accesstoken"] as String
    );
  }
}