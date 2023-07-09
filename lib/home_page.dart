import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/barcode_icons.dart';
import 'package:test_app/clients.dart';
import 'package:test_app/controllers/productscontroller.dart';
import 'package:test_app/core/utils/app_strings.dart';
import 'package:test_app/core/utils/constants.dart';
import 'package:test_app/products.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    ProductsController c = Get.put(ProductsController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Barcode.barcodeScan),
        onPressed: () async {
          String barcode = await c.getbarcodewithcam();
          c.searchedproduct = c.searchProductWithbarcode(barcode);
          if (c.searchedproduct != null) {
            c.showsearchedproduct.value = true;
          } else {
            c.showsearchedproduct.value = false;
          }
        },
      ),
      appBar: AppBar(title: const Text('Homepage')),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: padding),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const Clients());
                  },
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(cardpadding),
                    child: Column(children: [
                      const Icon(
                        Icons.account_box,
                        size: articleiconsize,
                      ),
                      Container(
                        padding: const EdgeInsets.all(padding),
                        child: Text(AppStrings.clients,
                            style: context.textTheme.headlineLarge),
                      )
                    ]),
                  )),
                ),
              ),
              Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: padding),
                child: InkWell(
                  onTap: () {
                    Get.to(() => Products());
                  },
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(cardpadding),
                    child: Column(children: [
                      const Icon(
                        Icons.article,
                        size: articleiconsize,
                      ),
                      Container(
                        padding: const EdgeInsets.all(padding),
                        child: Text(
                          AppStrings.products,
                          style: context.textTheme.headlineLarge,
                        ),
                      )
                    ]),
                  )),
                ),
              ),
              const SizedBox(
                height: sizedboxheight,
              ),
              GetX<ProductsController>(builder: (ch) {
                if (c.showsearchedproduct.value) {
                  return Card(
                    margin: const EdgeInsets.symmetric(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: padding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${AppStrings.name}: ${c.searchedproduct!.productname}",
                            style: context.textTheme.headlineMedium,
                          ),
                          const SizedBox(
                            height: sizedboxheight,
                          ),
                          Text(
                              "${AppStrings.price}: ${c.searchedproduct!.price} ${AppStrings.dzdCurrency}",
                              style: context.textTheme.headlineMedium),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              })
            ],
          ),
        ),
      )),
    );
  }
}
