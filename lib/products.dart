import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:test_app/addproduct.dart';

import 'models/productscontroller.dart';

class Products extends StatelessWidget {
  final ProductsController controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Container(
                child: IconButton(
                    onPressed: () {
                      controller.barcodecontroller.text="";
                      controller.pricecontroller.text="";
                      controller.productnamecontroller.text="";

                      Get.to(()=>Addproduct());
                    },
                    icon: Icon(Icons.add_circle_rounded),
                    iconSize: 80,
                    color: Colors.indigo[700]),
                margin: EdgeInsets.symmetric(vertical: 20),
              ),
              Flexible(child: GetX<ProductsController>(builder: (controller) {
                if (controller.listofproducts.length == 0) {
                  return Center(child: Text('no items'));
                } else
                  return ListView.separated(
                      itemBuilder: (context, idx) {
                        return ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                          child: Slidable(actionPane: SlidableDrawerActionPane(),
                              child: Container(color: Colors.grey[600],padding: EdgeInsets.symmetric(vertical: 20),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [

                                   Text(controller.listofproducts
                                       .elementAt(idx).productname,style: TextStyle(fontSize: 16,
                                       fontWeight: FontWeight.w400,color: Colors.white,
                                       letterSpacing: 1.2),
                                   ),
                                   Text("price : ${controller.listofproducts[idx].price}",
                                     style: TextStyle(fontSize: 16,color: Colors.white,
                                       fontWeight: FontWeight.w400,
                                       letterSpacing: 1.2),
                                   )

                                 ],

                          ),
                              ),actions: [IconSlideAction(color: Colors.grey[600]
                              .withOpacity(0.7),icon: Icons.edit,onTap: (){controller.productnamecontroller.text=controller.listofproducts[idx].productname;
                            controller.pricecontroller.text=controller.listofproducts[idx].price.toString();
                            controller.barcodecontroller.text=controller.listofproducts[idx].barcode;
                              Get.to(()=>Addproduct());},)],
                            secondaryActions: [IconSlideAction(color: Colors.grey[600]
                                .withOpacity(0.7),icon: Icons.delete,onTap: (){ controller.removeproduct(
                                controller.listofproducts[idx]);},)  ],),
                        );
                      },
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, int) {
                        return SizedBox(height: 20, );
                      },
                      itemCount: controller.listofproducts.length);
              })),
            ],
          ),
        ),
      ),
    );
  }
}
