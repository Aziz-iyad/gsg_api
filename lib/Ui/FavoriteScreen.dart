import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gsg_api/Data/db_helper.dart';
import 'package:gsg_api/Models/Product_Response.dart';
import 'package:gsg_api/Providers/myProvider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, x) {
          return provider.favouriteProducts == null
              ? Center(
                  child: Text('No Favourites'),
                )
              : ListView.builder(
                  itemCount: provider.favouriteProducts.length,
                  itemBuilder: (context, index) {
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
                            CachedNetworkImage(
                                imageUrl:
                                    provider.favouriteProducts[index].image),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                      provider.favouriteProducts[index].title,
                                      style: TextStyle(fontSize: 9)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    provider.favouriteProducts[index].price
                                        .toString(),
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
        },
      ),
    );
  }
}
