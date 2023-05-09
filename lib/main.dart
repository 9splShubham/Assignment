import 'dart:convert';
import 'package:assignment/add_to_cart/add_to_cart.dart';

import 'package:assignment/api.dart';
import 'package:assignment/db_helper.dart';
import 'package:assignment/model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

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

  late DbHelper dbHelper;

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

    for (int i = 0; i < mProductModel.length; i++) {
      storeData(i);
    }
    setState(() {
      print("Length------>${mProductModel.length}");
    });
  }

  void storeData(int index) async {
    ProductModel pModel = mProductModel[index];

    dbHelper = DbHelper();
    await dbHelper.saveData(pModel).then((product) {
      print("-------->successfully saved");
    }).catchError((error) {
      print("$error");
    });
    setState(() {
      print("Model Item--------------> ${pModel.image}");
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
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: DbHelper().fetchDataFromDB(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
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
                                    "${snapshot.data![index]['image']}",
                                  ),
                                ),
                                /*  child: Image.network(
                                  "${snapshot.data![index]['image']}",
                                ),*/
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("${snapshot.data![index]['title']}"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("${snapshot.data![index]['price']}"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "${snapshot.data![index]['description']}"),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
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
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),

        /*ListView.builder(
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
              })*/
      ),
    );
  }
}
/*
itemBuilder: (_, index) => Container(
child: Container(
margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
padding: EdgeInsets.all(20.0),
decoration: BoxDecoration(
color: Color(0xff97FFFF),
borderRadius: BorderRadius.circular(15.0),
),
child: Column(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
"${snapshot.data![index]['image']}",
style: TextStyle(
fontSize: 18.0,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 10),
Text("${snapshot.data![index]['price']}"),
],
),
),
),*/
