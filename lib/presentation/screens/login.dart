import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/core/utils/app_strings.dart';
import '../../core/utils/constants.dart';
import 'home_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

GlobalKey<FormState> globalformkey = GlobalKey<FormState>();

class LoginState extends State<Login> {
  bool isvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.all(margin),
            padding: const EdgeInsets.all(padding),
            child: Center(
              child: Form(
                key: globalformkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*     Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: size.width,
                      height: 120,
                      child: CustomPaint(
                        //  child: Align(child: Text('hello',style: TextStyle(fontSize: 30,color: Colors.white,fontFamily: 'PatrickHand')),alignment: Alignment.bottomCenter,),
                        painter: MyCustomPaint(),
                      ),
                    ), */
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        return val == username ? null : AppStrings.notValid;
                      },
                      style: context.textTheme.headlineMedium,
                      decoration: const InputDecoration(
                        labelText: username,
                      ),
                    ),
                    const SizedBox(height: sizedboxheight),
                    TextFormField(
                      validator: (val) {
                        return val == password ? null : AppStrings.notValid;
                      },
                      obscureText: !isvisible,
                      style: context.textTheme.headlineMedium,
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (v) {
                        if (globalformkey.currentState!.validate()) {
                          Get.off(() => const Homepage());
                        }
                      },
                      decoration: InputDecoration(
                        labelText: password,
                        suffixIcon: IconButton(
                          icon: Icon(isvisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              isvisible = !isvisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: sizedboxheight * 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (globalformkey.currentState != null &&
                              globalformkey.currentState!.validate()) {
                            Get.off(() => const Homepage());
                          }
                        },
                        child: const Text(
                          AppStrings.signIn,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}


