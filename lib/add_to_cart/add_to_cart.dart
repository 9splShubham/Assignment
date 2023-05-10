import 'dart:convert';
import 'package:assignment/api.dart';
import 'package:assignment/core/api_links.dart';
import 'package:assignment/core/app_string.dart';
import 'package:assignment/db_helper.dart';
import 'package:assignment/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddToCart extends StatefulWidget {
  AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  List<CartModel> mCartModel = [];

  late DbHelper dbHelper;

  @override
  void initState() {
    initData();
    dbHelper = DbHelper();
    super.initState();
  }

  void initData() async {
    var response = await ApiProvider().getMethod(Api.textCartAPI);
    mCartModel = List<CartModel>.from(
        jsonDecode(response).map((model) => CartModel.fromJson(model)));

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
                            Text(item.userId.toString()),
                            Text(item.date.toString()),
                            Text(item.products.toString()),
                            Text(item.iV.toString()),
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
