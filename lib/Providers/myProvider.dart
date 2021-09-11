import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gsg_api/Data/api_helper.dart';
import 'package:gsg_api/Data/db_helper.dart';
import 'package:gsg_api/Models/Product_Response.dart';

class HomeProvider extends ChangeNotifier {
  int bnbIndex = 0;
  bnb(int x) {
    bnbIndex = x;
    notifyListeners();
  }

  List<ProductResponse> cartProducts;
  List<ProductResponse> favouriteProducts;
  List<String> allCategories;
  List<ProductResponse> allProducts;
  List<ProductResponse> categoryProducts;
  ProductResponse selectedProduct;
  String selectedCategory = '';

  getAllProducts() async {
    List<dynamic> products = await ApiHelper.apiHelper.getAllProducts();
    allProducts = products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  getSpecificProduct(int id) async {
    dynamic response = await ApiHelper.apiHelper.getSpecificProduct(id);
    selectedProduct = ProductResponse.fromJson(response);
    notifyListeners();
  }

  getAllCategories() async {
    List<dynamic> categories = await ApiHelper.apiHelper.getAllCategories();
    allCategories = categories.map((e) => e.toString()).toList();
    notifyListeners();
    getCategoryProducts(allCategories.first);
  }

  getCategoryProducts(String category) async {
    categoryProducts = null;
    this.selectedCategory = category;
    notifyListeners();
    List<dynamic> products =
        await ApiHelper.apiHelper.getCategoryProducts(category);
    categoryProducts =
        products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  addToCart(ProductResponse productResponse) async {
    DbHelper.dbHelper.insertToCart(productResponse);
    print('Saved to cart!');
    print(selectedProduct.title);
    getAllCartProducts();
    notifyListeners();
  }

  getAllCartProducts() async {
    List<ProductResponse> products = await DbHelper.dbHelper.getAllCartItems();
    this.cartProducts = products;
    // cartProducts.forEach((element) {
    //   print(element.quantity);
    // });
    notifyListeners();
  }

  checkFavouriteToAdd(ProductResponse productResponse) async {}

  addToFavourite(ProductResponse productResponse) async {
    if (favouriteProducts == null) {
      await DbHelper.dbHelper.insertToFavourite(productResponse);
    } else {
      bool productInFavourite = favouriteProducts.any((x) {
        return x.id == productResponse.id;
      });

      if (productInFavourite) {
        deleteFromFavourite(productResponse.id);
      } else {
        await DbHelper.dbHelper.insertToFavourite(productResponse);
        print(productInFavourite);
        print('kos');
      }
    }
    print('Saved to Favourite!');
    print(productResponse.title);
    getAllFavouriteProducts();
    notifyListeners();
  }

  getAllFavouriteProducts() async {
    List<ProductResponse> products =
        await DbHelper.dbHelper.getAllFavouriteItems();
    this.favouriteProducts = products;
    notifyListeners();
  }

  deleteFromFavourite(int id) async {
    await DbHelper.dbHelper.deleteProductFromFavourite(id);
    getAllFavouriteProducts();
  }

  List<IconData> iconsTab = [
    FontAwesomeIcons.plug,
    FontAwesomeIcons.gem,
    FontAwesomeIcons.userTie,
    FontAwesomeIcons.female,
  ];
}
