import 'dart:convert';
import 'package:assignment/add_to_cart/add_to_cart.dart';
import 'package:assignment/api.dart';
import 'package:assignment/core/api_links.dart';
import 'package:assignment/core/app_string.dart';
import 'package:assignment/db_helper.dart';
import 'package:assignment/model/cart_model.dart';
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
      home: MyHomePage(),
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
    var response = await ApiProvider().getMethod(Api.textProdAPI);
    mProductModel = List<ProductModel>.from(
        jsonDecode(response).map((model) => ProductModel.fromJson(model)));

    for (int i = 0; i < mProductModel.length; i++) {
      storeData(i);
    }
    setState(() {});
  }

/*  void postCart() async {
    var response = await http.post(
      Uri.parse("https://fakestoreapi.com/carts"),
      body: {
        "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        "price": 109.95.toString(),
        "description":
            "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        "category": "men's clothing",
        "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"
      },
    );
    print(response.body);
    setState(() {});
  }*/

  void storeData(int index) async {
    ProductModel pModel = mProductModel[index];
    dbHelper = DbHelper();
    await dbHelper.saveData(pModel).then((product) {}).catchError((error) {});
    setState(() {});
  }

  void getProdData() async {
    dbHelper = DbHelper();
    mProductModel = await dbHelper.getProd(5);
    print("Get Prod Data");
    setState(() {});
  }

/*  void dd()async{
    dbHelper = DbHelper();
    await dbHelper.fetchDataFromDB().then((save){
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.textAssignment),
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
                                              /* postCart();*/
                                              /* getProdData();*/
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddToCart()));
                                            },
                                            child:
                                                Text(AppString.textAddToCart)),
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
      ),
    );
  }
}
