import 'package:flutter/material.dart';
import 'package:hunger/globalStates/userAuthProvider.dart';
import 'package:hunger/pages/components/customInput.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController pictureUrlController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    contactController.dispose();
    pictureUrlController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<UserAuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: 
      userAuth.isLoading 
           ? 
      const Center(
        child: CircularProgressIndicator(color: Colors.orange,)
      ):
       SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/dodle.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(20),
          //height: MediaQuery.of(context).size.height,
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
                const SizedBox(height: 20),
                Text(
                  "Hunger Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.brown[700],
                  ),
                ),
                const SizedBox(height: 20),
                CustomInput(
                  textEditor: userNameController,
                  obscure: false,
                  hint: "",
                  label: "Enter Your Name",
                  validatorTxt: "Invalid UserName",
                ),
                const SizedBox(height: 15),
                CustomInput(
                  textEditor: emailController,
                  obscure: false,
                  hint: "",
                  label: "Enter Your Email",
                  validatorTxt: "Invalid Email",
                ),
                const SizedBox(height: 15),
                CustomInput(
                  textEditor: passwordController,
                  obscure: true,
                  hint: "",
                  label: "Enter Your Password",
                  validatorTxt: "Invalid Password",
                ),
                const SizedBox(height: 15),
                CustomInput(
                  textEditor: contactController,
                  obscure: false,
                  hint: "",
                  label: "Enter Your Contact",
                  validatorTxt: "Invalid Contact",
                ),
                const SizedBox(height: 15),
                CustomInput(
                  textEditor: pictureUrlController,
                  obscure: false,
                  hint: "",
                  label: "Enter Your Picture Url",
                  validatorTxt: "Invalid Url",
                ),
                const SizedBox(height: 15),
                CustomInput(
                  textEditor: locationController,
                  obscure: false,
                  hint: "",
                  label: "Enter Your Location",
                  validatorTxt: "Invalid Location",
                ),
                const SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.brown[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final registerRes = userAuth.registerUser(
                          userNameController.text,
                          emailController.text,
                          passwordController.text, 
                          contactController.text, 
                          pictureUrlController.text, 
                          locationController.text
                        );
                        registerRes.then((response){
                          print(userAuth.statusCode);
                         print(userAuth.authData.token);
                         print(userAuth.authData.message);
                        });
                        //print(a);
                        //print(userAuth.statusCode);
                      }
                    },
                    child:const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have an Account? ",
                      style: TextStyle(
                        color: Colors.brown[700],
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print(userAuth.isLoading);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    
    );
  }
}
