import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StateSplashScreen();
  }
}

class StateSplashScreen extends State<SplashScreen>{

  getToken()async{
    return Timer(Duration(seconds: 2), () async {
      final simpanData = await SharedPreferences.getInstance();

      final token = simpanData.getString('token');
      if(token != null){
        return Navigator.pushReplacementNamed(context, Pages.Home);
      }
      else{
        return Navigator.pushReplacementNamed(context, Pages.Login);
      }

    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Center(child: CircularProgressIndicator(),));
  } 
}