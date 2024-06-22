import 'package:flutter/material.dart';

abstract class AppRouter {
  static dynamic route(
      BuildContext context, dynamic widget, {bool? replacement}) {
    if (replacement != null && replacement) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
    }
  }
}
