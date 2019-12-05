import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/pages.dart';

class AddTodo extends StatefulWidget{
  final handleToDo;

  const AddTodo(this.handleToDo);

  @override
  AddTodoState createState() {
    return AddTodoState(this.handleToDo);
  }
}

class AddTodoState extends State<AddTodo> {
  final handleToDo;
  AddTodoState(this.handleToDo);

  CameraDescription firstCamera;
  String path;

  final todoController = TextEditingController();

  final descriptionController = TextEditingController();
  @override
  void initState(){
    super.initState();
    getCamera();
  }

  getCamera() async{
    final cameras = await availableCameras();
    setState(() {
      firstCamera = cameras.first;
    });
  }

  navigateAndGetPhoto() async {
    final result = await Navigator.pushNamed(context, Pages.Camera, arguments: {"camera" : firstCamera});

    setState(() {
      path = result;
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Kerjaan')
      ),
      body: Column(children: <Widget>[
        TextField(
          controller: todoController,
          decoration: InputDecoration(
            helperText: 'Tambah Kerjaan'
          ),
        ),
        // Container(
        //   child: path != null
        //   ? Image.file(File(path))
        //   : IconButton(
        //     icon: Icon(Icons.camera),
        //     onPressed: (){
        //       navigateAndGetPhoto();
        //     },
        //   ),
        // ),
        // RaisedButton.icon(
        //   icon: Icon(Icons.add),
        //   onPressed: (){
        //     handleToDo(todoController.text, path);
        //     Navigator.pop(context);
        //   },
        //   label : Expanded(child: Card(),)
        // )
      ],),
    );
  }
}