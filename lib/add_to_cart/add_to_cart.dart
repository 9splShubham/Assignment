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
  List<CartModel> mCartModel = [];
  ProductModel mProductModel = ProductModel();
  var mCartProdModel = {};

/*  late Future<List<Map<String, dynamic>>> _futureData;*/

  late DbHelper dbHelper;

  @override
  void initState() {
    initData();
    dbHelper = DbHelper();
    /*  _futureData = dbHelper.fetchDataFromDB();*/
    super.initState();
  }

  void initData() async {
    var response = await ApiProvider().getMethod(Api.textCartAPI);
    mCartModel = List<CartModel>.from(
        jsonDecode(response).map((model) => CartModel.fromJson(model)));

    mCartProdModel.addAll(response);
    mCartProdModel.addAll(DbHelper().fetchDataFromDB() as Map);

    print("-----------------${mCartProdModel}");
    setState(() {});
  }

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
              /* FutureBuilder<List<Map<String, dynamic>>>(
                future: _futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Expanded(
                              child: Column(
                                children: [
                                  Text("${snapshot.data![index]['title']}"),
                                  Text("${snapshot.data![index]['price']}"),
                                  Text(
                                      "${snapshot.data![index]['description']}"),
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
                    return CircularProgressIndicator();
                  }
                },
              )*/
              ListView.builder(
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
                  })
            ],
          ),
        ),
      ),
    );
  }
}
