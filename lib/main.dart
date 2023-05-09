import 'dart:convert';
import 'package:assignment/add_to_cart/add_to_cart.dart';
import 'package:http/http.dart' as http;
import 'package:assignment/api.dart';
import 'package:assignment/db_helper.dart';
import 'package:assignment/model/model.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      /*  const MyHomePage(title: 'Flutter Demo Home Page'),*/
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductModel> mProductModel = [];

  var dbHelper;

  @override
  void initState() {
    initData();
    dbHelper = DbHelper();
    super.initState();
  }

  void initData() async {
    var response =
        await ApiProvider().getMethod('https://fakestoreapi.com/products');
    mProductModel = List<ProductModel>.from(
        jsonDecode(response).map((model) => ProductModel.fromJson(model)));

    setState(() {
      print('product---------${mProductModel.length}');
    });
  }

  void storeData() async {
    ProductModel pModel = ProductModel();

    pModel.title;
    pModel.price;
    pModel.description;
    pModel.category;
    pModel.image;
    pModel.rating;

    dbHelper = DbHelper();
    await dbHelper.getDataFromApi().then((product) {
      print("--------->${pModel.price}");
    }).catchError((error) {
      print("$error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment'),
        elevation: 0,
      ),
      body: Scaffold(
          body: ListView.builder(
              itemCount: mProductModel.length,
              itemBuilder: (context, index) {
                ProductModel item = mProductModel[index];
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
                          Image.network(
                            item.image!,
                            height: 70,
                            width: 70,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(item.title!),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(item.price.toString()),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(item.description!),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          storeData();
                                          /*          ui();*/
                                        },
                                        child: Text("Store In DB")),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddToCart()));
                                        },
                                        child: Text("Add To Cart")),
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
              })),
    );
  }
}
