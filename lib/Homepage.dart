import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/barcode_icons.dart';
import 'package:test_app/clients.dart';
import 'package:test_app/controllers/productscontroller.dart';
import 'package:test_app/products.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  @override
  Widget build(BuildContext context) {
    ProductsController c=Get.put(ProductsController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Barcode.barcode_scan),
        onPressed: () {
        String barcode;
       c.getbarcodewithcam().then((value){barcode=value;
       c.searchedproduct=c.searchProductWithbarcode(barcode);
       if (c.searchedproduct!=null) c.showsearchedproduct.value=true;
       else c.showsearchedproduct.value=false;

       });


      },backgroundColor: Colors.indigo[700],),
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () {
                    Get.to(()=>Clients());

                  },
                  child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(children: [
                          Icon(
                            Icons.account_box,
                            size: 150,
                            color: Colors.indigo[700],
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.indigo[700],
                                border: Border.all(
                                    width: 0.5, color: Colors.grey[500]),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Clients",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 1.2,
                                  color: Colors.white),
                            ),
                          )
                        ]),
                      )),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () {
                    Get.to(()=>Products());
                  },
                  child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(children: [
                          Icon(Icons.article,
                              size: 150, color: Colors.indigo[700]),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.indigo[700],
                                border: Border.all(
                                    width: 0.5, color: Colors.grey[500]),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "products",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 1.2,
                                  color: Colors.white),
                            ),
                          )
                        ]),
                      )),
                ),
              ),
              SizedBox(height: 10,),

              Container(margin: EdgeInsets.symmetric(horizontal: 30),
                child: GetX<ProductsController> (builder: (ch) {
                  if(c.showsearchedproduct.value){
                    print('yo');
                  return Card(margin: EdgeInsets.symmetric(),child: Container(width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(mainAxisSize: MainAxisSize.min,children: [
                      Text("name: ${c.searchedproduct.productname}",style: TextStyle(fontSize: 16),),
                      SizedBox(height: 10,),
                      Text("Price : ${c.searchedproduct.price} DA",style: TextStyle(fontSize: 16)),
                    ],
                    ),
                  ),
                  );
                } else return SizedBox();  }),
              )


            ],
          ),



        ),
      )
      ),

    );
  }
}
