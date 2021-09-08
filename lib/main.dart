import 'package:flutter/material.dart';
import 'package:gsg_api/Data/db_helper.dart';
import 'package:gsg_api/Helpers/AppRouter.dart';
import 'package:gsg_api/Providers/myProvider.dart';
import 'package:gsg_api/Ui/HomeScreen.dart';
import 'package:gsg_api/Ui/SplachScreen.dart';
import 'package:gsg_api/services/Bnb.dart';
import 'package:provider/provider.dart';
import 'Ui/product_DetailsScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDataBase();
  runApp(ChangeNotifierProvider<HomeProvider>(
    create: (_) => HomeProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        ProductDetails.routeName: (_) => ProductDetails(),
        Bnb.routeName: (_) => Bnb(),
      },
      home: SplachScreen(),
      navigatorKey: RouteHelper.routeHelper.navKey,
    ),
  ));
}
