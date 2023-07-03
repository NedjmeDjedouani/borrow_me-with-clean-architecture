import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Homepage.dart';
import 'package:test_app/core/utils/app_strings.dart';

import 'core/utils/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

GlobalKey<FormState> globalformkey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  bool isvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(margin),
            padding: EdgeInsets.all(padding),
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
                        return val == USERNAME ? null : AppStrings.notValid;
                      },
                      style: context.textTheme.headlineMedium,
                      decoration: InputDecoration(
                        labelText: USERNAME,
                      ),
                    ),
                    SizedBox(height: sizedboxheight),
                    TextFormField(
                      validator: (val) {
                        return val == PASSWORD ? null : AppStrings.notValid;
                      },
                      obscureText: !isvisible,
                      style: context.textTheme.headlineMedium,
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (v) {
                        if (globalformkey.currentState!.validate()) {
                          Get.off(() => Homepage());
                        }
                      },
                      decoration: InputDecoration(
                        labelText: PASSWORD,
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
                    SizedBox(
                      height: sizedboxheight * 2,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (globalformkey.currentState != null &&
                              globalformkey.currentState!.validate()) {
                            Get.off(() => Homepage());
                          }
                        },
                        child: Text(
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

class MyCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()..color = Colors.indigo.shade700;
    path.lineTo(0.25 * size.width, 0);
    path.lineTo(0.5 * size.width, 0.5 * size.height);
    path.lineTo(0.75 * size.width, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
