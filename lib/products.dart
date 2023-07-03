import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:test_app/addproduct.dart';
import 'package:test_app/core/utils/app_colors.dart';
import 'package:test_app/core/utils/app_strings.dart';
import 'controllers/productscontroller.dart';
import 'core/utils/constants.dart';

class Products extends StatelessWidget {
  final ProductsController controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: IconButton(
                    onPressed: () {
                      Get.to(() => Addproduct());
                    },
                    icon: Icon(Icons.add_circle_rounded),
                    iconSize: 80,
                    color:AppColors.primary),
              ),
              SizedBox(height: sizedboxheight,),
              Flexible(child: GetX<ProductsController>(builder: (controller) {
                if (controller.listofproducts.length == 0) {
                  return Center(child: Text(AppStrings.noItems));
                } else
                  return ListView.separated(
                      itemBuilder: (context, idx) {
                        return ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(borderradius),
                              bottomRight: Radius.circular(borderradius)),
                          child: Slidable(
                              child: Container(
                                color: AppColors.slidableBackground,
                                padding: EdgeInsets.symmetric(vertical: padding),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          controller.listofproducts
                                              .elementAt(idx)
                                              .productname!,
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          style: context.textTheme.bodyMedium),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        AppStrings.price +
                                            ": ${controller.listofproducts[idx].price!.toStringAsFixed(0)} " +
                                            AppStrings.dzdCurrency,
                                        softWrap: true,
                                        style: context.textTheme.bodyMedium,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              startActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    backgroundColor:
                                        AppColors.slidableBackground,
                                    icon: Icons.edit,
                                    onPressed: (ctx) {
                                      Get.to(() => Addproduct(),
                                          arguments:
                                              controller.listofproducts[idx]);
                                    },
                                  )
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    backgroundColor:
                                        AppColors.slidableBackground,
                                    icon: Icons.delete,
                                    onPressed: (ctx) {
                                      controller.removeproduct(
                                          controller.listofproducts[idx]);
                                    },
                                  )
                                ],
                              )),
                        );
                      },
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, int) {
                        return SizedBox(
                          height: sizedboxheight,
                        );
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
