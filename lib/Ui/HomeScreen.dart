import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_api/Helpers/AppRouter.dart';
import 'package:gsg_api/MyWidgets/IconTap.dart';
import 'package:gsg_api/Providers/myProvider.dart';
import 'package:gsg_api/Ui/product_DetailsScreen.dart';
import 'package:gsg_api/services/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static final routeName = '/HomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, provider, x) {
          return SafeArea(
            child: Column(
              children: [
                provider.allProducts == null
                    ? Container(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 1),
                                  spreadRadius: 5,
                                  blurRadius: 15,
                                ),
                              ]),
                          height: 200,
                          width: 400,
                          child: CarouselSlider(
                              items: provider.allProducts
                                  .map((e) =>
                                      CachedNetworkImage(imageUrl: e.image))
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
                      ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        'All Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                    ),
                  ],
                ),
                provider.allCategories == null
                    ? Container(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.allCategories.length,
                            itemBuilder: (context, index) {
                              return IconTap(
                                function: () {
                                  provider.getCategoryProducts(
                                      provider.allCategories[index]);
                                },
                                title: provider.allCategories[index][0]
                                        .toUpperCase() +
                                    provider.allCategories[index].substring(1),
                                color: provider.selectedCategory ==
                                        provider.allCategories[index]
                                    ? kMainColor
                                    : Colors.white,
                                iconColor: provider.selectedCategory ==
                                        provider.allCategories[index]
                                    ? Colors.white
                                    : kMainColor,
                                icon: provider.iconsTab[index],
                              );
                            }),
                      ),
                if (provider.categoryProducts == null)
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 400,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: kMainColor,
                      )),
                    ),
                  )
                else
                  Expanded(
                    flex: 3,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kStartColor.withOpacity(0.1),
                                      offset: Offset(0, 1),
                                      spreadRadius: 2,
                                      blurRadius: 9,
                                    ),
                                  ],
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        provider.categoryProducts[index].image),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // CachedNetworkImage(
                                    //   imageUrl: provider
                                    //       .categoryProducts[index].image,
                                    // ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: kMainColor.withOpacity(0.9)),
                                      child: Column(
                                        children: [
                                          Text(
                                            provider
                                                .categoryProducts[index].title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Price: ' +
                                                    provider
                                                        .categoryProducts[index]
                                                        .price
                                                        .toString() +
                                                    '\$',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    provider.addToFavourite(
                                                        provider.categoryProducts[
                                                            index]);
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    size: 25,
                                                    color: provider
                                                                .favouriteProducts
                                                                ?.any((element) =>
                                                                    element
                                                                        .id ==
                                                                    provider
                                                                        .categoryProducts[
                                                                            index]
                                                                        .id) ??
                                                            false
                                                        ? Colors.red
                                                        : Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        }),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
