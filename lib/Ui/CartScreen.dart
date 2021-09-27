import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gsg_api/Data/db_helper.dart';
import 'package:gsg_api/Helpers/AppRouter.dart';
import 'package:gsg_api/Models/Product_Response.dart';
import 'package:gsg_api/Providers/myProvider.dart';
import 'package:gsg_api/Ui/product_DetailsScreen.dart';
import 'package:gsg_api/services/constants.dart';
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
        backgroundColor: kStartColor,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, x) {
          return provider.cartProducts == null
              ? Center(
                  child: Text('No Items Added to Cart'),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: provider.cartProducts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        provider.getSpecificProduct(
                            provider.cartProducts[index].id);
                        RouteHelper.routeHelper.goTO(ProductDetails.routeName);
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.3),
                                  offset: Offset(0, 1),
                                  spreadRadius: 2,
                                  blurRadius: 9,
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        provider.cartProducts[index].image,
                                  ),
                                ),
                                SizedBox(height: 25),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: kMainColor.withOpacity(0.9)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          provider.cartProducts[index].title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text(
                                              'Price: ' +
                                                  provider
                                                      .cartProducts[index].price
                                                      .toString() +
                                                  '\$',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text('Buy it Now!',
                                                      style: TextStyle(
                                                        color: kMainColor,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: kMainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 45,
                              height: 45,
                              child: IconButton(
                                onPressed: () {
                                  provider.deleteFromCart(
                                      provider.cartProducts[index].id);
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }
}
