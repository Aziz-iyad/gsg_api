import 'package:flutter/cupertino.dart';

class RouteHelper {
  RouteHelper._();
  static RouteHelper routeHelper = RouteHelper._();
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  goTO(String routeName) {
    navKey.currentState.pushNamed(routeName);
  }

  goTOReplacement(String routeName) {
    navKey.currentState.pushReplacementNamed(routeName);
  }

  back() {
    navKey.currentState.pop();
  }
}
