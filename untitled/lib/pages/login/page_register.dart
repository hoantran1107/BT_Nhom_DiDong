
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Login.dart';
import 'dialogs.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  GlobalKey<FormState> fromSate = GlobalKey<FormState>();
  String? error="";
  bool _isObscure =true;
  TextEditingController txtUser = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtPassRe = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: fromSate,
              child: Center(
                  child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                validator: (value) => validateString(value),
                controller: txtUser,
                decoration: InputDecoration(label: Text("Email")),
              ),
              TextFormField(
                validator: (value) => validateString(value),
                obscureText: _isObscure,
                controller: txtPass,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    label: Text("Your password")),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                validator: (value) => validateString(value),
                obscureText: true,
                controller: txtPassRe,
                decoration: InputDecoration(label: Text("Retype your password")),
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: () {
                    bool? validate = fromSate.currentState?.validate();
                    if(validate == true){
                      error = "";
                      showSnackBar(context, "Registering ...", 600);
                      registerEmailPassword(email: txtUser.text, password: txtPass.text)
                      .then((value) {
                        setState(() {
                          error = "Registered successfully!";
                        });
                        showSnackBar(context, "Registered successfully", 3);
                      }).catchError((error){
                        setState(() {
                            this.error = error.toString();
                        });
                        showSnackBar(context, "Registered not successfully", 3);
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.vpn_key),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Register"),
                      SizedBox(height: 24,),
                    ],

                  )
              ),
            SizedBox(height: 24,),
            Text("${error}")
          ]),
        )),
            )));
  }
  validateString(String? value) {
    return value ==null || value.isEmpty ? "Bạn chưa nhập dữ liệu" : null;
  }
}
