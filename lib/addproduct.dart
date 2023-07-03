import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/barcode_icons.dart';
import 'package:test_app/controllers/productvalidationform.dart';
import 'package:test_app/core/utils/app_strings.dart';



class Addproduct extends StatefulWidget {
  @override
  _AddproductState createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> with TickerProviderStateMixin {
  final ProductValidationForm c = Get.put(ProductValidationForm());
  late Animation<double> opacity,opacity2,opacity3;
  late AnimationController animationController;

@override
void initState() {
 
animationController=AnimationController(vsync: this,duration: Duration(seconds: 1));
 opacity=Tween<double>(begin: 0.0,end: 1.0)
      .animate(CurvedAnimation(parent: animationController, curve:Interval(0, 0.33,curve: Curves.easeIn) ));
opacity2=Tween<double>(begin: 0.0,end: 1.0)
      .animate(CurvedAnimation(parent: animationController, curve:Interval(0.33,0.66,curve: Curves.bounceIn)));
opacity3=Tween<double>(begin: 0.0,end: 1.0)
      .animate(CurvedAnimation(parent: animationController, curve:Interval(0.66,1,curve: Curves.bounceOut) ));
  animationController.forward();
    super.initState();
  }
  void dispose() {
  animationController.dispose();
    super.dispose();
  }
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
                  FadeTransition(opacity:opacity ,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Name"),
                      validator: ProductValidationForm.namevalidator,
                      onSaved: (value) {
                        c.inputproductname = value!;
                      },
                      controller: c.productnamecontroller,
                    ),
                  ),
                  FadeTransition(
                    opacity: opacity2,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: AppStrings.price),
                      validator: ProductValidationForm.pricevalidator,
                      onSaved: (value) {
                        c.inputproductprice = value!;
                      },
                      controller: c.pricecontroller,
                    ),
                  ),
                  FadeTransition(
                    opacity: opacity3,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: c.barcodecontroller,
                      decoration: InputDecoration(
                          labelText: "barcode",
                          suffixIcon: IconButton(
                              onPressed: () async {
                              //  c.barcodecontroller.text =await c.pc.getbarcodewithcam();
                              },
                              icon: Icon(
                                Barcode.barcode_scan,
                                color: Colors.grey[600],
                              ))),
                      validator: ProductValidationForm.barcodevalidator,
                      onSaved: (value) {
                        c.inputproductbarcode = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          c.addOrUpdateProduct();
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
