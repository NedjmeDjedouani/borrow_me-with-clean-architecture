import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/barcode_icons.dart';
import 'package:test_app/controllers/productvalidationform.dart';
import 'package:test_app/core/utils/app_strings.dart';
import 'package:test_app/core/utils/constants.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  AddproductState createState() => AddproductState();
}

class AddproductState extends State<Addproduct> with TickerProviderStateMixin {
  final ProductValidationForm c = Get.put(ProductValidationForm());
  late Animation<double> opacity, opacity2, opacity3;
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 0.33, curve: Curves.easeIn)));
    opacity2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.33, 0.66, curve: Curves.bounceIn)));
    opacity3 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.66, 1, curve: Curves.bounceOut)));
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
      appBar: AppBar(
        title: const Text(AppStrings.addProduct),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: const EdgeInsets.all(padding),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: c.globalformkey,
              child: Column(
                children: [
                  FadeTransition(
                    opacity: opacity,
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: AppStrings.name),
                      validator: ProductValidationForm.namevalidator,
                      onSaved: (value) {
                        c.inputproductname = value!;
                      },
                      controller: c.productnamecontroller,
                    ),
                  ),
                  const SizedBox(
                    height: sizedboxheight,
                  ),
                  FadeTransition(
                    opacity: opacity2,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(labelText: AppStrings.price),
                      validator: ProductValidationForm.pricevalidator,
                      onSaved: (value) {
                        c.inputproductprice = value!;
                      },
                      controller: c.pricecontroller,
                    ),
                  ),
                  const SizedBox(
                    height: sizedboxheight,
                  ),
                  FadeTransition(
                    opacity: opacity3,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: c.barcodecontroller,
                      decoration: InputDecoration(
                          labelText: AppStrings.barcode,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                //  c.barcodecontroller.text =await c.pc.getbarcodewithcam();
                              },
                              icon: const Icon(
                                Barcode.barcodeScan,
                              ))),
                      validator: ProductValidationForm.barcodevalidator,
                      onSaved: (value) {
                        c.inputproductbarcode = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: sizedboxheight * 2  ,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        c.addOrUpdateProduct();
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
