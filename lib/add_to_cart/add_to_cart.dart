import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assignment/api.dart';
import 'package:assignment/core/api_links.dart';
import 'package:assignment/core/app_string.dart';
import 'package:assignment/db_helper.dart';
import 'package:assignment/model/cart_model.dart';
import 'package:assignment/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddToCart extends StatefulWidget {
  AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.textAddToCart),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
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
                        itemBuilder: (context, index)
                        {
                          print("-------${snapshot.data![index].title}");
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 3, color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      child: Image.network(
                                          "${snapshot.data![index].image}",

                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "ID : ${snapshot.data![index].id}"),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "User ID : ${snapshot.data![index].userId}"),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("${snapshot.data![index].title}"),

                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "Date : ${snapshot.data![index].date}"),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),

                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );

                         /*   Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 3, color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.network("${snapshot.data![index].image}",height: 40,width: 40,),

                                              Text("${snapshot.data![index].title}"),
                                              Text("${snapshot.data![index].date}"),


                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );*/
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
              ),
               )
            /*  ListView.builder(
                  itemCount: mCartModel.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    CartModel item = mCartModel[index];
                    print("----------------${item.userId}");
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text('User Id : ${[item.userId]}'),
                            Text('Date : ${[item.date]}'),
                            Text('Products : ${[item.products]}'),
                          ],
                        ),
                      ),
                    );
                  })*/
            ],
          ),
        ),
      ),
    );
  }
}
