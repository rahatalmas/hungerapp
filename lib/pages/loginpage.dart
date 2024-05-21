import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hunger/apiControllers/login.dart';
import 'package:hunger/dataModels/userModel.dart';
import 'package:hunger/globalStates/LoginInfoProvider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();
}


class _LoginPage extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController user_name_controller = TextEditingController();
  final TextEditingController user_password_controller = TextEditingController();

  String user_name = "";
  String user_password = "";
  late Future <UserLoginInfoModel> loginInfo;

  Future <UserLoginInfoModel> _form_Submit_controller(){
    if(_formKey.currentState!.validate()){
      setState(() {
        user_name = user_name_controller.text;
        user_password = user_password_controller.text;
      });
      print(user_name);
      loginInfo = userLogin(user_name, user_password);
      user_name_controller.clear();
      user_password_controller.clear();
      FocusScope.of(context).unfocus();
    }
    return loginInfo;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[100],
        body:SingleChildScrollView(
          physics:ClampingScrollPhysics(),
          child:  Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/dodle.jpg",),
                fit: BoxFit.cover

              )
            ),
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/soup.png",
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Text("Hunger Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.brown[700]
                    ),),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("User Name"),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.brown,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.brown,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.red,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.brown,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    controller: user_name_controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.brown,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.brown,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.red,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Colors.brown,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    controller: user_password_controller,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        //image:const DecorationImage(
                          //image: AssetImage("assets/download (1).jpg"),
                        //),
                        color: Colors.brown[500],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child:Consumer<LoginInfoProvider>(
                      builder: (context,user,child){
                        return InkWell(
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          onTap:(){
                            loginInfo = _form_Submit_controller();
                            user.setLoginInfo(loginInfo);
                          },
                        );
                      },
                    )
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Text("Don't Have Account? ",
                        style: TextStyle(
                      color: Colors.brown[700],
                          fontSize: 17,
                          fontWeight: FontWeight.w400
                      ),),
                      InkWell(
                        child: Text("SignUp",
                          style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
