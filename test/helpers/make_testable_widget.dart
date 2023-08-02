import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

Widget makeTestableWidget({
  required Widget child,
  NavigatorObserver? navigatorObserver,
}) {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final navigatorKey = GlobalKey<NavigatorState>();
  final navigatorObservers = <NavigatorObserver>[Asuka.asukaHeroController];
  if (navigatorObserver != null) navigatorObservers.add(navigatorObserver);

  return MaterialApp(
    builder: Asuka.builder,
    scaffoldMessengerKey: scaffoldMessengerKey,
    navigatorKey: navigatorKey,
    navigatorObservers: navigatorObservers,
    home: child,
  );
}
