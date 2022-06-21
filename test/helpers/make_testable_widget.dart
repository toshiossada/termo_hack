import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;

Widget makeTestableWidget({
  required Widget child,
  NavigatorObserver? navigatorObserver,
}) {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final navigatorKey = GlobalKey<NavigatorState>();
  final navigatorObservers = <NavigatorObserver>[asuka.asukaHeroController];
  if (navigatorObserver != null) navigatorObservers.add(navigatorObserver);

  return MaterialApp(
    builder: asuka.builder,
    scaffoldMessengerKey: scaffoldMessengerKey,
    navigatorKey: navigatorKey,
    navigatorObservers: navigatorObservers,
    home: child,
  );
}
