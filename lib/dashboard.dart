import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/addtodo.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/detailpage.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/todo.dart';
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

_InputData data = _InputData();

class _DashboardState extends State<Dashboard> {
  List<Todo> kerjaan;
  bool checkAll = false;
  String filtered = "total";
  bool loading = true;

  void getTodos() async {
    var response = await Todo.getTodos();
    print(response);
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

  Future<FormData> photo({path, name}) async {
    return FormData.fromMap({
      "name" : name,
      "favorite" : false,
      "photo" : await MultipartFile.fromFile(path, filename: "user-photo")
    });
  }

  handleToDo(val, path) {
      Todo.postTodo(photo(path: path, name: val));
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
    return Scaffold(
      appBar: AppBar(title: Text('List Kerjaan')),
      body: loading
      ? Text('loading')
      : Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Box(
                status: 'Done',
                warna: Colors.green,
                jumlah: jumlahChecked(),
                icon: Icon(Icons.check),
              ),
              Box(
                status: 'Kerjain',
                warna: Colors.red,
                jumlah: kerjaan.length - jumlahChecked(),
                icon: Icon(Icons.calendar_today),
              ),
              Box(
                status: 'Total',
                warna: Colors.black,
                jumlah: kerjaan.length,
                icon: Icon(Icons.people),
              ),
            ],
          ),
          Expanded(
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
          Container(
            padding: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width*14/15,
            height: MediaQuery.of(context).size.height*6/10,
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
                        leading: Icon(Icons.work),
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
       ),
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
    );
  }
}