import 'package:flutter/material.dart';
import 'package:short_share/route_gen.dart';
import 'package:short_share/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Short n Share';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
  ),
  darkTheme: ThemeData(
    brightness: Brightness.dark,
  ),
      title: appTitle,
      home: HomePage(title: appTitle),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
