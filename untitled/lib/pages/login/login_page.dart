import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../utils/colors.dart';
import 'FireBaseHome.dart';
import 'Login.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  String? thongBaoLoi="";
  @override
  Widget build(BuildContext context) {
    TextEditingController txtUser = TextEditingController();
    TextEditingController txtPass = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          title: Text("Login"),
        backgroundColor: AppColors.primaryPurple,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Image(image: AssetImage(
                  "assets/images/PetShop-removebg.png"
                )),
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  controller: txtUser,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                TextFormField(
                  controller: txtPass,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                SignInButtonBuilder(
                  text: 'Sign in with email',
                  icon: Icons.email,
                  onPressed: () async{
                    Get.snackbar("Nhắc nhở",
                        "Signing in ...",
                        backgroundColor: AppColors.mainColor,

                        colorText: Colors.white,
                        duration: Duration(seconds: 300));
                    //showSnackBar(context, "Signing in ...", 300);
                    if(txtUser.text!= "" && txtPass.text != ""){
                      thongBaoLoi = "";
                      Get.snackbar("Nhắc nhở",
                          "Signing in ...",
                          backgroundColor: AppColors.mainColor,

                          colorText: Colors.white,
                          duration: Duration(seconds: 300));
                      signWithEmailPassword(email: txtUser.text, password: txtPass.text)
                      .then((value) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomeFireBase(),)
                            , (Route<dynamic> route) => false);
                        Get.snackbar("Nhắc nhở",
                            'Hello ${FirebaseAuth.instance.currentUser?.email ??
                                ""}',
                            backgroundColor: AppColors.mainColor,

                            colorText: Colors.white,
                            duration: Duration(seconds: 5));
                      }).catchError((error) {
                        setState(() {
                          thongBaoLoi = error.toString();
                        });
                        Get.snackbar("Nhắc nhở",
                            'Sign in not successfully',
                            backgroundColor: AppColors.mainColor,

                            colorText: Colors.white,
                            duration: Duration(seconds: 3));

                      })
                      ;

                    }

                  },
                  backgroundColor: Colors.blueGrey[700]!,
                  width: 220.0,
                ),
                SignInButton(
                  Buttons.Google,
                  onPressed: () async {
                    Get.snackbar("Nhắc nhở",
                        'Đang đăng nhập',
                        backgroundColor: AppColors.mainColor,
                        colorText: Colors.white,
                        duration: Duration(seconds: 5));
                    var user = await signWithGoogle();
                    if (user != null) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeFireBase(),)
                          , (Route<dynamic> route) => false);
                      Get.snackbar("Nhắc nhở",

                          'Hello ${FirebaseAuth.instance.currentUser?.email ??
                              ""}',
                          backgroundColor: AppColors.mainColor,

                          colorText: Colors.white,
                          duration: Duration(seconds: 5));
                    }
                    else {
                      setState(() {

                      });
                      Get.snackbar("Nhắc nhở",
                          'Sign in not succesfully',
                          backgroundColor: AppColors.mainColor,

                          colorText: Colors.white,
                          duration: Duration(seconds: 3));
                    }
                  },
                ),
                SizedBox(height: 20,),
                Row(
                  children: [

                      Text("Dont have an account"),
                      const SizedBox(width: 10,),
                      TextButton(onPressed: () {
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => ,));
                      }, child: Text("register"))
                    ],),
                ElevatedButton(
                  style: ButtonStyle(
                  ),
                  onPressed: () async {
                    await signWithGoogle().whenComplete(() =>
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const HomeFireBase())))
                    ;

                    //page firebase
                  }, child: Text("Đăng nhập",)

                ),
                Text("${thongBaoLoi}")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
