import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextpageass/controller/restaurant_controller.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final restaurantController = Get.put(RestaurantController());

  @override
  void initState() {
    // TODO: implement initState
    restaurantController.getRestaurantModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(() => SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: restaurantController.resList.length,
                  itemBuilder: (context, index) {
                    var res = restaurantController.resList[index];
                    return Card(
                      child: Column(
                        children: [
                          Text(res.name ?? "N/A"),
                          Text(res.description ?? "N/A"),
                          Row(
                            children: [
                              Text(res.averageRating.toString()),
                              TextButton(
                                  onPressed: () async {
                                    // await showDialog(
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return Container(
                                    //         color: Colors.yellow,
                                    //         width: 200,
                                    //         height: 100,
                                    //         child: Column(
                                    //           mainAxisSize: MainAxisSize.min,
                                    // children: [
                                    //   TextButton(
                                    //       onPressed: () {
                                    //         restaurantController
                                    //             .updateRating(
                                    //                 id: res.id,
                                    //                 rating: 1);
                                    //         Navigator.pop(context);
                                    //       },
                                    //       child: const Text("1")),
                                    //   TextButton(
                                    //       onPressed: () {
                                    //         restaurantController
                                    //             .updateRating(
                                    //                 id: res.id,
                                    //                 rating: 2);
                                    //         Navigator.pop(context);
                                    //       },
                                    //       child: const Text("2")),
                                    //   TextButton(
                                    //       onPressed: () {
                                    //         restaurantController
                                    //             .updateRating(
                                    //                 id: res.id,
                                    //                 rating: 3);
                                    //         Navigator.pop(context);
                                    //       },
                                    //       child: const Text("3")),
                                    //   TextButton(
                                    //       onPressed: () {
                                    //         restaurantController
                                    //             .updateRating(
                                    //                 id: res.id,
                                    //                 rating: 4);
                                    //         Navigator.pop(context);
                                    //       },
                                    //       child: const Text("4")),
                                    //   TextButton(
                                    //       onPressed: () {
                                    //         restaurantController
                                    //             .updateRating(
                                    //                 id: res.id,
                                    //                 rating: 5);
                                    //         Navigator.pop(context);
                                    //       },
                                    //       child: const Text("5")),
                                    // ],
                                    //         ));
                                    //   },
                                    // );
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: Text("Rate Now"),
                                            // content: /* Here add your custom widget  */
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    restaurantController
                                                        .updateRating(
                                                            id: res.id,
                                                            rating: 1);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("1")),
                                              TextButton(
                                                  onPressed: () {
                                                    restaurantController
                                                        .updateRating(
                                                            id: res.id,
                                                            rating: 2);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("2")),
                                              TextButton(
                                                  onPressed: () {
                                                    restaurantController
                                                        .updateRating(
                                                            id: res.id,
                                                            rating: 3);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("3")),
                                              TextButton(
                                                  onPressed: () {
                                                    restaurantController
                                                        .updateRating(
                                                            id: res.id,
                                                            rating: 4);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("4")),
                                              TextButton(
                                                  onPressed: () {
                                                    restaurantController
                                                        .updateRating(
                                                            id: res.id,
                                                            rating: 5);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("5")),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text("Rate Now"))
                            ],
                          )
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          )),
    ));
  }
}
