import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/barcode_icons.dart';
import 'package:test_app/models/productscontroller.dart';
import 'models/product.dart';

ProductsController controller = Get.find();

class Addproduct extends StatelessWidget {
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
              key: controller.globalformkey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Name"),
                    validator: controller.namevalidator,
                    onSaved: (value) {
                      controller.inputproductname = value;
                    },
                    controller: controller.productnamecontroller,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Price"),
                    validator: controller.pricevalidator,
                    onSaved: (value) {
                      controller.inputproductprice = value;
                    },
                    controller: controller.pricecontroller,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller.barcodecontroller,
                    decoration: InputDecoration(
                        labelText: "barcode",
                        suffixIcon: IconButton(
                            onPressed: () async {
                              await controller
                                  .getbarcodewithcam()
                                  .then((value) {
                                controller.inputproductbarcode = value;
                                controller.barcodecontroller.text =
                                    controller.inputproductbarcode;
                              });
                            },
                            icon: Icon(
                              Barcode.barcode_scan,
                              color: Colors.grey[600],
                            ))),
                    validator: controller.barcodevalidator,
                    onSaved: (value) {
                      controller.inputproductbarcode = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (controller.globalformkey.currentState
                              .validate()) {
                            controller.globalformkey.currentState.save();
                            if (controller.selectedproduct == null) {
                              Product p = Product(
                                  controller.inputproductname,
                                  controller.inputproductbarcode,
                                  double.parse(controller.inputproductprice));
                              controller.barcodecontroller.clear();
                              controller.pricecontroller.clear();
                              controller.productnamecontroller.clear();
                              controller.addproduct(p);
                              Get.snackbar('item is registered', '');
                            } else {
                              controller.editproduct(Product.withid(
                                  controller.selectedproduct.id,
                                  controller.inputproductname,
                                  controller.inputproductbarcode,
                                  double.tryParse(
                                      controller.inputproductprice)));
                              Get.back();
                            }

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
