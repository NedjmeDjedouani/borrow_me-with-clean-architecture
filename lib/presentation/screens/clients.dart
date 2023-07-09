import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_app/core/utils/app_colors.dart';
import 'package:test_app/core/utils/constants.dart';
import '../../core/utils/app_strings.dart';
import '../../core/widgets/apperrorwidget.dart';
import '../controllers/clientcontroller.dart';
import 'addclient.dart';
import 'addorder.dart';


class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  ClientsState createState() => ClientsState();
}

class ClientsState extends State<Clients> {
  final Clientscontroller c = Get.put(Clientscontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, // <-- Button color
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(padding),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const AddClient()));
                },
                child: const Icon(Icons.add, size: 40, color: Colors.white),
              ),
              const SizedBox(
                height: sizedboxheight * 2,
              ),
              Expanded(child: GetX<Clientscontroller>(builder: (controller) {
                if (c.error.value.isNotEmpty) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      c.getallclients();
                    },
                    child: Center(
                      child: AppErrorWidget(
                        message: c.error.value,
                      ),
                    ),
                  );
                }
                if (c.listofclients.isEmpty) {
                  return const Center(child: Text(AppStrings.noClients));
                } else {
                  return RefreshIndicator.adaptive(
                    onRefresh: () async {
                      c.getallclients();
                    },
                    child: ListView.separated(
                        itemBuilder: (context, idx) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: padding / 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(borderradius),
                              child: Slidable(
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        backgroundColor:
                                            AppColors.slidableBackground,
                                        icon: Icons.edit,
                                        onPressed: (ctx) {
                                          Get.to(() => const AddClient(),
                                              arguments: c.listofclients[idx]);
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
                                          c.removeclient(c.listofclients[idx]);
                                        },
                                      )
                                    ],
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    color: AppColors.primary,
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => Addorder(),
                                            arguments: c.listofclients[idx]);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: padding),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      c.listofclients[idx]
                                                          .firstname!,
                                                      style: const TextStyle(
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      c.listofclients[idx]
                                                          .lastname!,
                                                      style: const TextStyle(
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      c.listofclients[idx]
                                                          .balance!
                                                          .toStringAsFixed(0),
                                                      style: const TextStyle(
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: sizedboxheight,
                                              ),
                                              Text(
                                                  "${AppStrings.createdAt}: ${DateFormat.yMd().add_Hm().format(c.listofclients[idx].createdAt!)}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontFamily: 'PatrickHand',
                                                      fontSize: 18,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.white,
                                                      letterSpacing: 1.2),
                                                  softWrap: true),
                                            ]),
                                      ),
                                    ),
                                  )),
                            ),
                          );
                        },
                        separatorBuilder: (context, idx) {
                          return const SizedBox(
                            height: sizedboxheight,
                          );
                        },
                        itemCount: c.listofclients.length),
                  );
                }
              })),
            ],
          ),
        ),
      ),
    );
  }
}
