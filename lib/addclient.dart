import 'package:flutter/material.dart';
import 'package:test_app/models/clientcontroller.dart';
import 'package:get/get.dart';
import 'package:test_app/models/orderscontroller.dart';

import 'clients.dart';
import 'models/client.dart';


class AddClient extends StatelessWidget {
  Clientscontroller c=Get.find();
Client editclient=Get.arguments;
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
                  key: c.globalkeyform,
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        initialValue: editclient!=null ? editclient.firstname : "",
                        decoration: InputDecoration(labelText: "FirstName"),
                        validator: Clientscontroller.namevalidator,
                        onSaved: (value) {
                          c.inputclientfirstname = value;
                        },
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        initialValue: editclient!=null  ? editclient.lastname :"",
                        decoration: InputDecoration(labelText: "lastname"),
                        validator: Clientscontroller.namevalidator,
                        onSaved: (value) {
                          c.inputclientlastname = value;
                        },
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        initialValue:editclient!=null ? editclient.phonenumber :"" ,
                        keyboardType:  TextInputType.phone,
                        decoration: InputDecoration(labelText: "Phonenumber"),
                        validator: Clientscontroller.phonevalidator,
                        onSaved: (value) {
                          c.inputphonenumber = value;
                        },
                      ),
                      TextFormField(
                        initialValue:editclient!=null ? editclient.balance.toString() :"" ,
                        decoration: InputDecoration(labelText: "balance"),
                        keyboardType:TextInputType.number,
                        validator: Clientscontroller.namevalidator,
                        onSaved: (value) {
                          c.inputclientbalance = value;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                            onPressed: () {
                              if (c.globalkeyform.currentState.validate()) {
                                c.globalkeyform.currentState.save();
                                if (editclient==null){
                                Client client = Client(c.inputclientfirstname,c.inputclientlastname,c.inputphonenumber,double.tryParse(c.inputclientbalance));
                                c.addclient(client);}
                                else {
                                 c.editclient(Client.withid(editclient.id,c.inputclientfirstname,c.inputclientlastname,c.inputphonenumber,double.tryParse(c.inputclientbalance)));
                                }
                                Get.back();
                              }
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