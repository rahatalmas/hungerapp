class UserAuth{
  String? message;
  String? token;
  UserAuth({this.message,this.token});

  UserAuth.formjson(Map<String,dynamic>json){
    message = json["message"];
    token = json["accesstoken"];
  }
  
}
