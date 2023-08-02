import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setObservers([Asuka.asukaHeroController]);
    return MaterialApp.router(
      builder: Asuka.builder,
      debugShowCheckedModeBanner: false,
      title: 'Termo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0x00615458,
          {
            50: Color(0x00dfdcdd),
            100: Color(0x00b0a9ab),
            200: Color(0x0090878a),
            300: Color(0x00706568),
            500: Color(0x00615458),
            600: Color(0x004d4346),
            700: Color(0x003a3234),
            800: Color(0x001d191a),
            900: Color(0x00000000),
          },
        ),
      ),
      routerConfig: Modular.routerConfig,
    ); //
  }
}
