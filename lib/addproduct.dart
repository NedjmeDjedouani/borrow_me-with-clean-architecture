import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/barcode_icons.dart';
import 'package:test_app/models/productscontroller.dart';
import 'package:test_app/productvalidationform.dart';
import 'models/product.dart';


class Addproduct extends StatelessWidget {
  ProductValidationForm c=Get.put(ProductValidationForm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add product'),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: c.globalformkey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Name"),
                    validator: ProductValidationForm.namevalidator,
                    onSaved: (value) {
                      c.inputproductname = value;
                    },
                    controller: c.productnamecontroller,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Price"),
                    validator: ProductValidationForm.pricevalidator,
                    onSaved: (value) {
                      c.inputproductprice = value;
                    },
                    controller: c.pricecontroller,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: c.barcodecontroller,
                    decoration: InputDecoration(
                        labelText: "barcode",
                        suffixIcon: IconButton(
                            onPressed: () async {
                              await c.pc
                                  .getbarcodewithcam()
                                  .then((value) {
                                c.barcodecontroller.text =value;
                              });
                            },
                            icon: Icon(
                              Barcode.barcode_scan,
                              color: Colors.grey[600],
                            ))),
                    validator: ProductValidationForm.barcodevalidator,
                    onSaved: (value) {
                      c.inputproductbarcode = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          c.isproductformvalid();
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
