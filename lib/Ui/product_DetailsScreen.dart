import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gsg_api/Helpers/AppRouter.dart';
import 'package:gsg_api/Providers/myProvider.dart';
import 'package:gsg_api/services/constants.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static final routeName = '/ProductDetails';
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, provider, index) {
          return Stack(alignment: Alignment.center, children: [
            Column(children: [
              Stack(children: [
                Container(
                  height: deviceHeight / 2,
                  color: kMainColor.withOpacity(0.04),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 55, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(FontAwesomeIcons.arrowLeft)),
                            Icon(CupertinoIcons.share),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 100),
                  child: Container(
                    height: deviceHeight / 2.4,
                    child: CachedNetworkImage(
                      imageUrl: provider.selectedProduct.image,
                      // fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ]),
              Expanded(
                child: Container(
                  color: kStartColor.withOpacity(0.03),
                  child: Column(
                    children: [
                      SizedBox(height: 75),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Description',
                            style: TextStyle(
                                color: kMainColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            provider.selectedProduct.description,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 125,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        color: provider.favouriteProducts?.any((element) =>
                                    element.id ==
                                    provider.selectedProduct.id) ??
                                false
                            ? Colors.white.withOpacity(0.5)
                            : kMainColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              provider.addToFavourite(provider.selectedProduct);
                            },
                            icon: Icon(FontAwesomeIcons.heart),
                            color: provider.favouriteProducts?.any((element) =>
                                        element.id ==
                                        provider.selectedProduct.id) ??
                                    false
                                ? Colors.red
                                : Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            provider.addToCart(provider.selectedProduct);
                            RouteHelper.routeHelper.back();
                          },
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(20),
                            color: kMainColor,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: kMainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 125,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Expanded(
                          child: Text(
                            provider.selectedProduct.title,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                'Price: ' +
                                    provider.selectedProduct.price.toString() +
                                    '\$',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]);
        },
      ),
    );
  }
}
