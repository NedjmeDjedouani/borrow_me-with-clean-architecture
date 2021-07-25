import 'package:flutter/material.dart';
import 'package:test_app/clientformvalidation.dart';
import 'package:get/get.dart';

class AddClient extends StatelessWidget {
 final ClientFormValidation cfv=Get.put(ClientFormValidation());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: cfv.globalkeyform,
              child: Column(
                children: [
                  TextFormField(  //first name
                    controller: cfv.inputfirstnamecontroller,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "FirstName"),
                    validator: ClientFormValidation.namevalidator,
                    onSaved: (value) {
                      cfv.inputfirstname = value;
                    },
                  ),
                  TextFormField(  //lastname
                    controller: cfv.inputlastnamecontroller,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "lastname"),
                    validator: ClientFormValidation.namevalidator,
                    onSaved: (value) {
                      cfv.inputlastname = value;
                    },
                  ),
                  TextFormField( //phonenumber
                    controller: cfv.inputphonenumbercontroller,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: "Phonenumber"),
                    validator: ClientFormValidation.phonevalidator,
                    onSaved: (value) {
                      cfv.inputphonenumber = value;
                    },
                  ),
                  TextFormField( //balance
                    controller: cfv.inputbalancecontroller,
                    decoration: InputDecoration(labelText: "balance"),
                    keyboardType: TextInputType.number,
                    validator: ClientFormValidation.namevalidator,
                    onSaved: (value) {
                      cfv.inputbalance = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          cfv.isclientformvalid();
                        },
                        child: Text('submit')),
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
