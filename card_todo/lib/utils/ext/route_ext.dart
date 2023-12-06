import 'package:card_todo/config/routes/params/params.dart';
import 'package:flutter/material.dart';

extension NavigatorPushNamed on BuildContext {
  Future goTo({required String route, RouteParams? params}) {
    return Navigator.of(this).pushNamed(route, arguments: params);
  }
}

extension NavigatorPushReplacementNamed on BuildContext {
  Future goToReplace({required String route, RouteParams? params}) {
    return Navigator.of(this).pushReplacementNamed(route, arguments: params);
  }
}
