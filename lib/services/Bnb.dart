import 'package:flutter/material.dart';
import 'package:gsg_api/Providers/myProvider.dart';
import 'package:gsg_api/Ui/CartScreen.dart';
import 'package:gsg_api/Ui/FavoriteScreen.dart';
import 'package:gsg_api/Ui/HomeScreen.dart';
import 'package:gsg_api/services/constants.dart';
import 'package:provider/provider.dart';

class Bnb extends StatelessWidget {
  static final routeName = '/bnb';

  List<Widget> bnbScreens = [HomeScreen(), FavoriteScreen(), CartScreen()];
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, x) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: provider.bnbIndex,
            selectedItemColor: Colors.black,
            selectedIconTheme: IconThemeData(color: kMainColor),
            unselectedIconTheme: IconThemeData(color: Colors.black),
            elevation: 100,
            onTap: (int x) {
              provider.bnb(x);
            },
            items: [
              BottomNavigationBarItem(
                label: 'home',
                icon: Icon(
                  Icons.home_outlined,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Favorite',
                icon: Icon(
                  Icons.favorite,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                icon: Icon(
                  Icons.shopping_bag_outlined,
                ),
              ),
            ],
          ),
          body: bnbScreens[provider.bnbIndex],
        );
      },
    );
  }
}
