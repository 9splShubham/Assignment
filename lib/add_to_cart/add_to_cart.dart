import 'package:http/http.dart' as http;
import 'package:assignment/core/app_string.dart';
import 'package:assignment/db_helper.dart';
import 'package:assignment/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  List<CartProdModel> mCartProdModel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.textAddToCart),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: FutureBuilder<List<CartProdModel>>(
                  future: DbHelper().getJoinedData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 3, color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      child: Image.network(
                                        "${snapshot.data![index].image}",
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Text(AppString.textID),
                                              Text(
                                                  " ${snapshot.data![index].id}"),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Text(AppString.textUserID),
                                              Text(
                                                  " ${snapshot.data![index].userId}"),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "${snapshot.data![index].title}"),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Text(AppString.textPrice),
                                              Text(
                                                  " ${snapshot.data![index].price.toString()}"),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Text(AppString.textDate),
                                              Text(
                                                  " ${snapshot.data![index].date}"),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Center(child: const CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
