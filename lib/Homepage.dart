import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/barcode_icons.dart';
import 'package:test_app/clients.dart';
import 'package:test_app/controllers/productscontroller.dart';
import 'package:test_app/core/utils/app_colors.dart';
import 'package:test_app/core/utils/app_strings.dart';
import 'package:test_app/core/utils/constants.dart';
import 'package:test_app/products.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    ProductsController c = Get.put(ProductsController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Barcode.barcode_scan),
        onPressed: () async {
          String barcode = await c.getbarcodewithcam();
          c.searchedproduct = c.searchProductWithbarcode(barcode);
          if (c.searchedproduct != null)
            c.showsearchedproduct.value = true;
          else
            c.showsearchedproduct.value = false;
        },
      ),
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
                    Get.to(() => Clients());
                  },
                  child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(children: [
                          Icon(
                            Icons.account_box,
                            size: 150,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.indigo[700],
                                border: Border.all(
                                    width: borderwidth,
                                    color: Colors.grey.shade500),
                                borderRadius:
                                    BorderRadius.circular(borderradius)),
                            child: Text("Clients",
                                style: context.textTheme.bodyMedium),
                          )
                        ]),
                      )),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () {
                    Get.to(() => Products());
                  },
                  child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(cardpadding),
                        child: Column(children: [
                          Icon(
                            Icons.article,
                            size: articleiconsize,
                          ),
                          Container(
                            padding: EdgeInsets.all(padding),
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                border: Border.all(
                                    width: borderwidth,
                                    color: AppColors.borderColor),
                                borderRadius:
                                    BorderRadius.circular(borderradius)),
                            child: Text(
                              "products",
                              style: context.textTheme.headlineLarge,
                            ),
                          )
                        ]),
                      )),
                ),
              ),
              SizedBox(
                height: sizedboxheight,
              ),
              Container(
                child: GetX<ProductsController>(builder: (ch) {
                  if (c.showsearchedproduct.value) {
                    return Card(
                      margin: EdgeInsets.symmetric(),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "name: ${c.searchedproduct!.productname}",
                              style: context.textTheme.headlineMedium,
                            ),
                            SizedBox(
                              height: sizedboxheight,
                            ),
                            Text(
                                AppStrings.price +
                                    ": ${c.searchedproduct!.price} " +
                                    AppStrings.dzdCurrency,
                                style: context.textTheme.headlineMedium),
                          ],
                        ),
                      ),
                    );
                  } else
                    return SizedBox();
                }),
              )
            ],
          ),
        ),
      )),
    );
  }
}
