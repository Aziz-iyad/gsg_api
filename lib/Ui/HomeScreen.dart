import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_api/Helpers/AppRouter.dart';
import 'package:gsg_api/Providers/myProvider.dart';
import 'package:gsg_api/Ui/product_DetailsScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static final routeName = '/HomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, x) {
          return Column(
            children: [
              provider.allProducts == null
                  ? Container(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Container(
                      height: 200,
                      child: CarouselSlider(
                          items: provider.allProducts
                              .map((e) => CachedNetworkImage(imageUrl: e.image))
                              .toList(),
                          options: CarouselOptions(
                            height: 200,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          )),
                    ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      'All Categories',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                  ),
                ],
              ),
              provider.allCategories == null
                  ? Container(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: provider.allCategories
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  provider.getCategoryProducts(e);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    color: provider.selectedCategory == e
                                        ? Colors.orangeAccent
                                        : Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:
                                      Text(e[0].toUpperCase() + e.substring(1)),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
              provider.categoryProducts == null
                  ? Container(
                      height: 400,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: provider.categoryProducts.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                provider.getSpecificProduct(
                                    provider.categoryProducts[index].id);
                                RouteHelper.routeHelper
                                    .goTO(ProductDetails.routeName);
                              },
                              child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(5),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: CachedNetworkImage(
                                            imageUrl: provider
                                                .categoryProducts[index].image),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(provider
                                              .categoryProducts[index].title),
                                          Text('Price: ' +
                                              provider
                                                  .categoryProducts[index].price
                                                  .toString() +
                                              '\$'),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    ),
            ],
          );
        },
      ),
    );
  }
}
