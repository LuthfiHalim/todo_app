import 'package:flutter/material.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/pageroute.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forms in Flutter',
      initialRoute: '/dashboard',
      onGenerateRoute: Router().getRoute,
    );
  }
}
