import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gsg_api/Data/db_helper.dart';
import 'package:gsg_api/Models/Product_Response.dart';
import 'package:gsg_api/Providers/myProvider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'),
      ),
      body: FutureBuilder(
          future: DbHelper.dbHelper.getAllCartItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<ProductResponse> cartItems = snapshot.data;
              return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    print(cartItems[index].image);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 15,
                                offset: Offset(1, 1),
                                color: Colors.black.withOpacity(0.12),
                              ),
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                                child: CachedNetworkImage(
                                    imageUrl: cartItems[index].image)),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(cartItems[index].title,
                                      style: TextStyle(fontSize: 15)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    cartItems[index].price.toString(),
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(child: Text('error'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
