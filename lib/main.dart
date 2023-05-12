import 'dart:convert';
import 'package:assignment/add_to_cart/add_to_cart.dart';
import 'package:assignment/api.dart';
import 'package:assignment/core/api_links.dart';
import 'package:assignment/core/app_string.dart';
import 'package:assignment/db_helper.dart';
import 'package:assignment/model/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      home: const MyHomePage(),
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

  late DbHelper dbHelper;
  late List<Map<String, dynamic>> snapshot;
  @override
  void initState() {
    initData();
    dbHelper = DbHelper();
    super.initState();
  }

  void initData() async {
    var response = await ApiProvider().getMethod(Api.textProdAPI);
    mProductModel = List<ProductModel>.from(
        jsonDecode(response).map((model) => ProductModel.fromJson(model)));

    for (int i = 0; i < mProductModel.length; i++) {
      storeData(i);
    }
    snapshot = await DbHelper().fetchDataFromDB();
    setState(() {});
  }

  void storeData(int index) async {
    ProductModel pModel = mProductModel[index];
    dbHelper = DbHelper();
    await dbHelper.saveData(pModel).then((product) {}).catchError((error) {});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.textAssignment),
        elevation: 0,
      ),
      body: Scaffold(
        body: (snapshot.isNotEmpty)
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
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
                              child: Image(
                                image: CachedNetworkImageProvider(
                                  "${snapshot[index]['image']}",
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text("${snapshot[index]['title']}"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("${snapshot[index]['price']}"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("${snapshot[index]['description']}"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AddToCart()));
                                          },
                                          child: const Text(
                                              AppString.textAddToCart)),
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
                })
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
