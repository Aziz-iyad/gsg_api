import 'package:flutter/material.dart';
import 'package:gsg_api/Data/db_helper.dart';
import 'package:gsg_api/Helpers/AppRouter.dart';
import 'package:gsg_api/Providers/myProvider.dart';
import 'package:gsg_api/services/Bnb.dart';
import 'package:gsg_api/services/constants.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getAllProducts();
    Provider.of<HomeProvider>(context, listen: false).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then(
        (value) => RouteHelper.routeHelper.goTOReplacement(Bnb.routeName));
    return Scaffold(
      backgroundColor: kStartColor,
      body: Center(
          child: Image.asset(
        "assets/images/logo.png",
        width: 300,
      )),
    );
  }
}
