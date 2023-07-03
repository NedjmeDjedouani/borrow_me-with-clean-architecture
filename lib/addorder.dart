import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:test_app/controllers/orderscontroller.dart';
import 'package:test_app/features/order/domain/entities/orderentity.dart';
import 'package:test_app/features/order/domain/entities/productentity.dart';
import 'package:test_app/utils/utils.dart';
import 'controllers/productscontroller.dart';
import 'package:intl/intl.dart';

class Addorder extends StatelessWidget {
  final ProductsController productsController = Get.put(ProductsController());
  final Ordercontroller orderController = Get.put(Ordercontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Form(
                key: orderController.globalformkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: TypeAheadFormField<ProductEntity>(
                                  debounceDuration: Duration(milliseconds: 500),
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    style: TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                        labelText: "Order name/price",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5)),
                                    controller: orderController
                                        .orderinputtextcontroller,
                                  ),
                                  validator: Ordercontroller.ordervalidator,
                                  suggestionsCallback:
                                      productsController.searchProduct,
                                  itemBuilder: (c, p) {
                                    return ListTile(
                                        title: Text(p.productname!),
                                        trailing: Text(p.price.toString()));
                                  },
                                  onSuggestionSelected: (p) {
                                    orderController.orderinputtextcontroller
                                        .text = p.productname!;
                                    orderController.inputprice =
                                        p.price.toString();
                                  },
                                  hideOnEmpty: true,
                                  onSaved: (val) {
                                    if (Utils.isNumeric(val)) {
                                      orderController.inputprice = val;
                                      orderController.inputordername =
                                          "Unknown";
                                    } else {
                                      orderController.inputordername = val;
                                    }
                                  },
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 18),
                                validator: orderController.quantityvalidator,
                                decoration: InputDecoration(
                                    labelText: "quantity",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5)),
                                onChanged: (value) {
                                  orderController.inputquantity = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                if (orderController.globalformkey.currentState!
                                    .validate()) {
                                  orderController.globalformkey.currentState!
                                      .save();
                                  OrderEntity order = OrderEntity(
                                      name: orderController.inputordername,
                                      price: double.tryParse(
                                          orderController.inputprice!),
                                      clientId:
                                          orderController.selectedclient?.id!,
                                      quantity: int.tryParse(
                                          orderController.inputquantity!)!,
                                      createdAt: DateTime.now());

                                  await orderController.saveorderitem(order);
                                }
                              },
                              child: Text(
                                'add order',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GetX<Ordercontroller>(builder: (c) {
              return Text("Total : ${c.totalprice}");
            }),
            SizedBox(
              height: 50,
            ),
            Flexible(
                flex: 3,
                child: GetX<Ordercontroller>(builder: (c) {
                  if (c.listoforders.length > 0) {
                    return ListView.separated(
                        itemBuilder: (context, idx) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Slidable(
                                startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (ctx) {
                                          c.removeorderitem(c.listoforders[idx],
                                              );
                                        },
                                        icon: Icons.delete,
                                        backgroundColor: Colors.grey.shade500,
                                      )
                                    ]),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.grey[600],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          c.listoforders[idx].name!,
                                          style: TextStyle(
                                              fontFamily: 'PatrickHand',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              letterSpacing: 1.2),
                                          softWrap: true,
                                        ),
                                        Text("${c.listoforders[idx].price} DA",
                                            style: TextStyle(
                                                fontFamily: 'PatrickHand',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                letterSpacing: 1.2),
                                            softWrap: true),
                                        Text(
                                            "quantity : ${c.listoforders[idx].quantity}",
                                            style: TextStyle(
                                                fontFamily: 'PatrickHand',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                letterSpacing: 1.2),
                                            softWrap: true),
                                        Text(
                                            "created At : ${DateFormat.yMd().add_Hm().format(c.listoforders[idx].createdAt!)}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                letterSpacing: 1.2),
                                            softWrap: true),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, idx) {
                          return SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: c.listoforders.length);
                  } else
                    return Container(
                      height: double.infinity,
                      child: Text('No items'),
                    );
                }))
          ],
        ),
      ),
    );
  }
}
