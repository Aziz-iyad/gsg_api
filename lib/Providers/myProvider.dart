import 'package:flutter/material.dart';
import 'package:gsg_api/Data/api_helper.dart';
import 'package:gsg_api/Data/db_helper.dart';
import 'package:gsg_api/Models/Product_Response.dart';

class HomeProvider extends ChangeNotifier {
  int bnbIndex = 0;
  bnb(int x) {
    bnbIndex = x;
    notifyListeners();
  }

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

  addToCart() async {
    ProductResponse productResponse = ProductResponse(
      title: selectedProduct.title,
      description: selectedProduct.description,
      price: selectedProduct.price,
      category: selectedProduct.category,
      image: selectedProduct.image,
    );
    DbHelper.dbHelper.insertToCart(productResponse);
    print('Saved to cart!');
    print(selectedProduct.title);
    notifyListeners();
  }

  addToFavourite() async {
    ProductResponse productResponse = ProductResponse(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        category: selectedProduct.category);
    DbHelper.dbHelper.insertToFavourite(productResponse);
    print('Saved to Favourite!');
    print(selectedProduct.title);
    notifyListeners();
  }
}
