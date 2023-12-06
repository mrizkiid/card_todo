import 'package:card_todo/config/routes/params/params.dart';
import 'package:flutter/material.dart';

Future goTo(
    {required BuildContext context,
    required String route,
    required RouteParams params}) {
  return Navigator.of(context).pushNamed(route);
}
