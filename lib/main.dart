import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/core/utils/app_colors.dart';

import 'core/utils/constants.dart';
import 'features/order/data/di/injector.dart';
import 'login.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: ThemeData(
        cardTheme: CardTheme(
          elevation: cardelevation,
        ),
        inputDecorationTheme: InputDecorationTheme(
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderradius),
            borderSide: BorderSide(
                color: AppColors.borderColor,
                width: borderwidth ,
                style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderradius),
            borderSide: BorderSide(
                color: AppColors.borderColor,
                width: borderwidth ,
                style: BorderStyle.solid),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderradius),
            borderSide: BorderSide(
                color: AppColors.primary!,
                width: borderwidth ,
                style: BorderStyle.solid),
          ),
          labelStyle: context.textTheme.headlineSmall,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: borderwidth ,
              color: AppColors.primary!,
            ),
            borderRadius: BorderRadius.circular(borderradius),
          ),
        ),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: AppColors.primary),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: context.textTheme.headlineLarge,
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.all(buttonpadding)),
        ),
        fontFamily: 'PatrickHand',
        primaryColor: AppColors.primary,
        buttonTheme: ButtonThemeData(buttonColor: AppColors.primary),
      ),
    );
  }
}
