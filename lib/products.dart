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

  Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                  onPressed: () {
                    Get.to(() => const Addproduct());
                  },
                  child: const Icon(Icons.add, size: 40)),
              const SizedBox(
                height: sizedboxheight * 2,
              ),
              FutureBuilder(
                  future: controller.getallproducts(),
                  builder: (ctx, snapshot) {
                    return Flexible(
                        child: GetX<ProductsController>(builder: (controller) {
                      if (controller.listofproducts.isEmpty) {
                        return const Center(child: Text(AppStrings.noItems));
                      } else {
                        return ListView.separated(
                            itemBuilder: (context, idx) {
                              return ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(borderradius),
                                    bottomRight: Radius.circular(borderradius)),
                                child: Slidable(
                                    startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          backgroundColor:
                                              AppColors.slidableBackground,
                                          icon: Icons.edit,
                                          onPressed: (ctx) {
                                            Get.to(() => const Addproduct(),
                                                arguments: controller
                                                    .listofproducts[idx]);
                                          },
                                        )
                                      ],
                                    ),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
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
                                    ),
                                    child: Container(
                                      color: AppColors.primary,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: padding),
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
                                                style: context
                                                    .textTheme.headlineMedium
                                                    ?.copyWith(
                                                        color: Colors.white)),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "${controller.listofproducts[idx].price!.toStringAsFixed(0)} ${AppStrings.dzdCurrency}",
                                              softWrap: true,
                                              style: context
                                                  .textTheme.headlineMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            },
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, _) {
                              return const SizedBox(
                                height: sizedboxheight,
                              );
                            },
                            itemCount: controller.listofproducts.length);
                      }
                    }));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
