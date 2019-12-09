import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/addtodo.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/detailpage.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/pages.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'box_widget.dart';
import 'detailpage.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _InputData {
  String deskripsi = '';
  int urutan;
}


class _DashboardState extends State<Dashboard> {
  
  int _selectedIndex = 0;

  Future<FormData> photo({path, name}) async {
    return FormData.fromMap({
      "name" : name,
      "favorite" : false,
      "photo" : await MultipartFile.fromFile(path, filename: "user-photo")
    });
  }
    
  handleToDo( val, path) {
    Todo.postTodo(photo(path: path, name: val));
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget bodyChoice(index){
    switch (index) {
      case 0 :
        return Home();

      case 1 :
        return Request(); 

      case 2 :
        return History();   

      case 3 :
        return Logout();    
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Kerjaan')),
      body: 
      bodyChoice(_selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(

        elevation: 10,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTodo(handleToDo)));
        },
        icon: Icon(Icons.work),
        label: Text('Add'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Request'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text('History'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('MyProfile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}


class Logout extends StatelessWidget{

  logout(context)async{
    final simpanData = await SharedPreferences.getInstance();
    simpanData.remove('token');
    Navigator.pushReplacementNamed(context, Pages.Login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: RaisedButton(
        child: Text('Logout'),
        onPressed: (){
          logout(context);
        },
      ),),
    );
  } 
}
class History extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: RaisedButton(
        child: Text('History'),
        onPressed: (){},
      ),),
    );
  } 
}
class Request extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: RaisedButton(
        child: Text('Request'),
        onPressed: (){},
      ),),
    );
  } 
}

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StateHome();
  }
}

class StateHome extends State<Home>{
  List<Todo> kerjaan;
  bool checkAll = false;
  String filtered = "total";
  _InputData data = _InputData();
  bool loading = true;

  void getTodos() async {
    var response = await Todo.getTodos();
    setState(() {
      kerjaan = response;
      loading = false;
    });
  }
  @override
  void initState(){
    super.initState();
    print('init');
    getTodos();
  }

  editKerjaan(Todo todo, index) {
      Todo.patchTodo({'name' : todo.name}, todo.id);
      getTodos();
  }

  removeWidget(Todo job, index){
    Todo.deleteTodos(job.id);
    kerjaan.removeAt(index);
    getTodos();
  }

  clickCheckBox(Todo todo, cek, index) {
    Todo.patchTodo({'favorite' : cek}, todo.id);
    getTodos();
  }

  clickCheckAll(val){
    for (var i = 0; i < kerjaan.length; i++) {
      Todo.patchTodo({'favorite' : val}, kerjaan[i].id);
      kerjaan[i].checked = val;
    }
    setState(() {
      checkAll = val;
    });
  }
  clickDeleteButton(){
    setState(() {
      //int total = kerjaan.length;
      for (int i = 0;i<kerjaan.length;i++) {
        if(kerjaan[i].checked){
          Todo.deleteTodos(kerjaan[i].id);
          kerjaan.removeAt(i);
          i--;
        }
      }
      getTodos();
      checkAll = false;
    });
  }


  int jumlahChecked(){
    int jumlah = 0;
    setState(() {
      for (var item in kerjaan) {
        if(item.checked){
          jumlah++;
        }
      }
    });
    return jumlah;
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Box(
                status: 'Done',
                warna: Colors.green,
                jumlah: loading ? 0 : jumlahChecked(),
                icon: Icon(Icons.check),
              ),
              Box(
                status: 'Kerjain',
                warna: Colors.red,
                jumlah: loading ? 0 : kerjaan.length - jumlahChecked(),
                icon: Icon(Icons.calendar_today),
              ),
              Box(
                status: 'Total',
                warna: Colors.black,
                jumlah: loading ? 0 : kerjaan.length,
                icon: Icon(Icons.people),
              ),
            ],)
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Spacer(flex: 1,),
                Expanded(
                  flex: 4,
                  child : Text('Check All'),
                ),
                Expanded(
                  flex: 2,
                  child: 
                    Checkbox(
                      value: checkAll,
                      onChanged: (val){
                        clickCheckAll(val);
                      },
                    ),
                ),
                Expanded(
                  flex: 5,
                  child: Text('Delete Checked'),
                ),
                Expanded(
                  flex: 3,
                    child: RaisedButton.icon(
                    key: Key('value'),
                    elevation: 0,
                    label: Expanded(
                      child: Card(),
                    ),
                    color: Colors.transparent,
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      clickDeleteButton();
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                   child : RaisedButton.icon(
                   elevation: 0,
                    label: Expanded(
                      child: Card(),
                    ),
                   color: Colors.transparent,
                   icon: Icon(Icons.refresh),
                   onPressed: (){
                     getTodos();
                   },
                  ),
                )
            ],),
          ),
          loading
          ? Expanded(flex:7,child:Center(child:Text('loading')))
          : Expanded(
            // padding: EdgeInsets.only(top: 10),
            // width: MediaQuery.of(context).size.width*14/15,
            // height: MediaQuery.of(context).size.height*6/10,
            flex: 7,
            child: kerjaan.length == 0 
            ? Text('''Tambahkan Kerjaan!



          ==>''',style: TextStyle(color: Colors.blue,fontSize: 48),)
            :ListView.builder(
              shrinkWrap: true,
              itemCount: kerjaan.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      removeWidget(kerjaan[index], index);
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    index: index,
                                    fungsi: editKerjaan,
                                    kerjaan: kerjaan[index],
                                  )));
                          
                        },
                        onLongPress: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreenEdit(
                                        kerjaan: kerjaan[index],
                                        index: index,
                                        fungsi: editKerjaan,
                                      )));
                        },
                        leading: kerjaan[index].imagepath == null
                        ? Icon(Icons.work)
                        :  CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.network(kerjaan[index].imagepath),
                        ),
                        trailing: Checkbox(
                          value: kerjaan[index].checked,
                          onChanged: (val) {
                            clickCheckBox(kerjaan[index], val, index);
                            if(val == false){
                              checkAll = false;
                            }
                            int temp = 0;
                            for (var i = 0; i < kerjaan.length; i++) {
                              if(kerjaan[i].checked){
                                temp++;
                              }
                            }
                            if(temp == kerjaan.length){
                              checkAll = true;
                            }
                          },
                        ),
                        title: kerjaan[index].checked 
                        ? Text('${kerjaan[index].name} [${index + 1}]',style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.green))
                        : Text('${kerjaan[index].name} [${index + 1}]',style: TextStyle(decoration: TextDecoration.none, color: Colors.red)),
                      
                      ),
                    ));
              },
            ),
          )
          ],
       );
  } 
}
