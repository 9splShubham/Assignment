import 'dart:convert';
import 'package:assignment/api.dart';
import 'package:assignment/model/cart_model.dart';
import 'package:http/http.dart' as http;
import 'package:assignment/model/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper {
  late Database _db;

  static const String DB_Name = 'MyDataBase.db';
  static const String Table_Product = 'products';
  static const int Version = 11;
  static const String Prod_Id = 'id';
  static const String Prod_Title = 'title';
  static const String Prod_Price = 'price';
  static const String Prod_Desc = 'description';
  static const String Prod_Category = 'category';
  static const String Prod_Image = 'image';
  static const String Prod_Rating = 'rating';

  // CART
/*  static const String Table_Cart = 'cart';
  static const String Cart_ID = 'cartId';
  static const String Cart_User_ID = 'cartProdId';
  static const String Cart_Date = 'cartImage';
  static const String Cart_Products = 'cartTitle';*/

  Future<Database> get db async {
    /* if (_db != null) {
      return _db;
    }*/
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_Product ("
        " $Prod_Id INTEGER PRIMARY KEY, "
        " $Prod_Title TEXT, "
        " $Prod_Price INTEGER ,"
        " $Prod_Desc TEXT,"
        " $Prod_Category TEXT,"
        " $Prod_Image TEXT,"
        " $Prod_Rating TEXT "
        ")");

/*    await db.execute("CREATE TABLE $Table_Cart ("
        " $Cart_ID INTEGER PRIMARY KEY, "
        " $Cart_User_ID INTEGER PRIMARY KEY, "
        " $Cart_Date INTEGER, "
        " $Cart_Products INTEGER"
        ")");*/
  }
  //SAVE DATA

  Future<int> saveData(ProductModel product) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_Product, product.toJson());
    return res;
  }

  Future<List<Map<String, dynamic>>> fetchDataFromDB() async {
    var dbClient = await db;
    var res = await dbClient.rawQuery('''SELECT * FROM $Table_Product''');

    return res;
  }

/*  Future<int> saveCart(CartModel cart) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_Cart, cart.toJson());
    return res;
  }*/

  Future<List> getDataFromApi() async {
    final response =
        await ApiProvider().getMethod('https://fakestoreapi.com/products');
    final List responseData = json.decode(response);
    final List models = [];
    responseData.forEach((modelData) {
      final ProductModel model = ProductModel.fromJson(modelData);
      DbHelper().saveData(model).then((product) {});
      models.add(model);
      print("----------getDataFromApi");
    });
    return models;
  }
}
