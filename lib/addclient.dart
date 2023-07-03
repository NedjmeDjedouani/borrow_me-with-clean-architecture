import 'package:flutter/material.dart';
import 'package:test_app/controllers/clientformvalidation.dart';
import 'package:get/get.dart';
import 'package:test_app/core/utils/app_strings.dart';
import 'package:test_app/core/utils/constants.dart';

class AddClient extends StatefulWidget {
  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> with TickerProviderStateMixin {
   late AnimationController animationController;
  late Animation<double> opacity, opacity2, opacity3, opacity4;
  final ClientFormValidation cfv = Get.put(ClientFormValidation());

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.25, curve: Curves.easeIn)));
    opacity2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.25, 0.5, curve: Curves.bounceIn)));
    opacity3 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 0.75, curve: Curves.bounceOut)));
    opacity4 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.75, 1, curve: Curves.bounceOut)));
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(padding),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: cfv.globalkeyform,
              child: Column(
                children: [
                  FadeTransition(
                    opacity:opacity,
                    child: TextFormField(
                      //first name
                      controller: cfv.inputfirstnamecontroller,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: AppStrings.firstName),
                      validator: ClientFormValidation.namevalidator,
                      onSaved: (value) {
                        cfv.inputfirstname = value!;
                      },
                    ),
                  ),
                  FadeTransition(
                    opacity: opacity2,
                    child: TextFormField(
                      //lastname
                      controller: cfv.inputlastnamecontroller,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: AppStrings.lastName),
                      validator: ClientFormValidation.namevalidator,
                      onSaved: (value) {
                        cfv.inputlastname = value!;
                      },
                    ),
                  ),
                  FadeTransition(opacity: opacity3,
                    child: TextFormField(
                      //phonenumber
                      controller: cfv.inputphonenumbercontroller,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: AppStrings.phoneNumber),
                      validator: ClientFormValidation.phonevalidator,
                      onSaved: (value) {
                        cfv.inputphonenumber = value!;
                      },
                    ),
                  ),
                  FadeTransition(
                    opacity: opacity4,
                    child: TextFormField(
                      //balance
                      controller: cfv.inputbalancecontroller,
                      decoration: InputDecoration(labelText: AppStrings.balance),
                      keyboardType: TextInputType.number,
                      validator: ClientFormValidation.balancevalidator,
                      onSaved: (value) {
                        cfv.inputbalance = value!;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(style: ElevatedButton.styleFrom(padding:EdgeInsets.symmetric(horizontal: 30) ),
                        onPressed: () {
                          cfv.isclientformvalid();
                        },
                        child: Text(AppStrings.submit)),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
