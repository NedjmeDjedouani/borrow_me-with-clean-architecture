import 'package:flutter/material.dart';
import 'package:test_app/controllers/clientformvalidation.dart';
import 'package:get/get.dart';
import 'package:test_app/core/utils/app_strings.dart';
import 'package:test_app/core/utils/constants.dart';
import 'package:test_app/utils/utils.dart';

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  AddClientState createState() => AddClientState();
}

class AddClientState extends State<AddClient> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> opacity, opacity2, opacity3, opacity4;
  final ClientFormValidation cfv = Get.put(ClientFormValidation());

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 0.25, curve: Curves.easeIn)));
    opacity2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.25, 0.5, curve: Curves.bounceIn)));
    opacity3 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 0.75, curve: Curves.bounceOut)));
    opacity4 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.75, 1, curve: Curves.bounceOut)));
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
        padding: const EdgeInsets.all(padding),
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
                    opacity: opacity,
                    child: TextFormField(
                      //first name
                      controller: cfv.inputfirstnamecontroller,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: AppStrings.firstName),
                      validator: Utils.namevalidator,
                      onSaved: (value) {
                        cfv.inputfirstname = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: sizedboxheight,
                  ),
                  FadeTransition(
                    opacity: opacity2,
                    child: TextFormField(
                      //lastname
                      controller: cfv.inputlastnamecontroller,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(labelText: AppStrings.lastName),
                      validator: Utils.namevalidator,
                      onSaved: (value) {
                        cfv.inputlastname = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: sizedboxheight,
                  ),
                  FadeTransition(
                    opacity: opacity3,
                    child: TextFormField(
                      //phonenumber
                      controller: cfv.inputphonenumbercontroller,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          labelText: AppStrings.phoneNumber),
                      validator: Utils.phonevalidator,
                      onSaved: (value) {
                        cfv.inputphonenumber = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: sizedboxheight,
                  ),
                  FadeTransition(
                    opacity: opacity4,
                    child: TextFormField(
                      //balance
                      controller: cfv.inputbalancecontroller,
                      decoration:
                          const InputDecoration(labelText: AppStrings.balance),
                      keyboardType: TextInputType.number,
                      validator: Utils.balancevalidator,
                      onSaved: (value) {
                        cfv.inputbalance = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: sizedboxheight * 2,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        cfv.isclientformvalid();
                      },
                      child: const Text(AppStrings.submit))
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
