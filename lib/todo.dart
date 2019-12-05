import 'package:dio/dio.dart';

class Todo {
  final String name;
  final String address;
  final int id;

  bool checked = false;

  Todo(this.name, this.address, this.id, this. checked);

  Todo.fromJSON(Map<String,dynamic> response)
      : name = response['name'],
        address = response['address'],
        checked = response['favorite'],
        id = response['id']
        ;
  
  static getTodos() async {
    var response = 
        await Dio().get("https://address-book-exp-api.herokuapp.com/users");
    
    List<Todo> todos = (response.data['data'] as List).map((item) => Todo.fromJSON(item)).toList();

    return todos;
  }

  static postTodo(data) async {
    var response = await Dio().post("https://address-book-exp-api.herokuapp.com/users", data: data);
    return response;
  }
  static patchTodo(data, id) async {
    var response = await Dio().patch("https://address-book-exp-api.herokuapp.com/users/$id", data: data);
    return response;
  }
  static deleteTodos(id) async {
    var response = await Dio().delete("https://address-book-exp-api.herokuapp.com/users/$id");
    return response;
  }
}
