import 'package:flutter/material.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/addtodo.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/camera.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/dashboard.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/detailpage.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/loginpage.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/pages.dart';

class Router{
  Route<dynamic> getRoute(settings){
    Map<String, dynamic> arguments = settings.arguments;

    switch (settings.name) {
      case Pages.Home :
        return _buildRoute(settings, LoginPage());
      case (Pages.List):
        return _buildRoute(settings, Dashboard());
      case Pages.Add :
        return _buildRoute(settings, AddTodo(arguments['handleToDo']));
      case Pages.Edit :
        return _buildRoute(
          settings, 
          DetailScreenEdit(
            kerjaan: arguments['kerjaan'],
            index: arguments['index'],
            fungsi: arguments['editKerjaan'],
          )
        );
      case Pages.Detail :
        return _buildRoute(
          settings, 
          DetailScreen(
            kerjaan: arguments['kerjaan'],
            index: arguments['index'],
            fungsi: arguments['editKerjaan'],
          )
        );
      case Pages.Camera :
        return _buildRoute(
          settings, 
          TakePictureScreen(camera: arguments['camera'],)
          );
      default:
        return null;
    }
  }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder){
  return MaterialPageRoute(
    builder: (ctx) => builder,
    settings: settings,
  );
}

