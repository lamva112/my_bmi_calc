import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
