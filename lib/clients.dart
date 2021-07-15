import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:test_app/addorder.dart';
import 'package:test_app/models/clientcontroller.dart';
import 'addclient.dart';
import 'models/client.dart';
import 'models/orderscontroller.dart';

class Clients extends StatefulWidget {
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  final Clientscontroller c = Get.put(Clientscontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: IconButton(
                    onPressed: () {
                      Get.to(() => AddClient());
                    },
                    icon: Icon(Icons.add_circle_rounded),
                    iconSize: 80,
                    color: Colors.indigo[700]),
                margin: EdgeInsets.symmetric(vertical: 20),
              ),
              Expanded(child: GetX<Clientscontroller>(builder: (controller) {
                if (c.listofclients.length == 0) {
                  return Center(child: Text('no Clients'));
                } else
                  return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (context, idx) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ClipRRect(borderRadius: BorderRadius.circular(10),
                              child: Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.grey[600],
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => Addorder(),
                                          arguments: c.listofclients[idx]);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  c.listofclients[idx].firstname,
                                                  style: TextStyle(
                                                      height: 1.5,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  c.listofclients[idx].lastname,
                                                  style: TextStyle(
                                                      height: 1.5,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  c.listofclients[idx].lastname,
                                                  style: TextStyle(
                                                      height: 1.5,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                                actions: [
                                  IconSlideAction(
                                    color: Colors.grey[600].withOpacity(0.7),
                                    icon: Icons.edit,
                                    onTap: () {
                                      Get.to(() => AddClient(),
                                          arguments:
                                              c.listofclients.elementAt(idx));
                                    },
                                  )
                                ],
                                secondaryActions: [
                                  IconSlideAction(
                                    color: Colors.grey[600].withOpacity(0.7),
                                    icon: Icons.delete,
                                    onTap: () {
                                      c.removeclient(c.listofclients[idx]);
                                    },
                                  )
                                ],
                              ),
                            ),
                        );
                      },
                      separatorBuilder: (context,idx){return SizedBox(height: 5,);},
                      itemCount: c.listofclients.length);
              })),
            ],
          ),
        ),
      ),
    );
  }
}
