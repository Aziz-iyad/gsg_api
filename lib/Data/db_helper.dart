import 'package:gsg_api/Models/Product_Response.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:io';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();
  static String dbName = 'api.db';

  static String cartTableName = 'Cart';
  static String favoriteTableName = 'Favorite';

  static String idColumnName = 'id';
  static String titleColumnName = 'title';
  static String priceColumnName = 'price';
  static String descriptionColumnName = 'description';
  static String categoryColumnName = 'category';
  static String imageColumnName = 'image';
  //

  Database database;

  initDataBase() async {
    database = await getDataBaseConnection();
  }

  Future<Database> getDataBaseConnection() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/$dbName';
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, v) {
        print('data base have been created');
        db.execute('''CREATE TABLE $cartTableName (
          $idColumnName INTEGER PRIMARY KEY ,
           $titleColumnName TEXT,
           $priceColumnName TEXT,
           $descriptionColumnName  TEXT,
           $categoryColumnName  TEXT,
           $imageColumnName TEXT
           )''');
        db.execute('''CREATE TABLE $favoriteTableName (
          $idColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
           $titleColumnName TEXT,
           $priceColumnName TEXT,
           $descriptionColumnName  TEXT,
           $categoryColumnName  TEXT,
           $imageColumnName TEXT
           )''');
      },
      onOpen: (database) {
        print('data base is open');
      },
    );
    return database;
  }

  insertToCart(ProductResponse productResponse) async {
    int rowNum = await database.insert(cartTableName, productResponse.toMap());
    print(rowNum);
  }

  insertToFavourite(ProductResponse productResponse) async {
    int rowNum =
        await database.insert(favoriteTableName, productResponse.toMap());
    print(rowNum);
  }

  Future<List<ProductResponse>> getAllCartItems() async {
    List<Map<String, Object>> result = await database.query(cartTableName);
    List cartItems = result.map((e) {
      return ProductResponse.fromMap(e);
    }).toList();
    print(cartItems.length);
    return cartItems;
  }

  Future<List<ProductResponse>> getAllFavouriteItems() async {
    List<Map<String, Object>> result = await database.query(favoriteTableName);
    List favItems = result.map((e) {
      return ProductResponse.fromMap(e);
    }).toList();
    return favItems;
  }

  deleteProductFromFavourite(int id) async {
    database.delete(favoriteTableName, where: 'id=?', whereArgs: [id]);
  }
}
