import 'package:flutter/material.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/todo.dart';


class DetailScreen extends StatelessWidget {
  
  final Todo kerjaan;
  final fungsi;
  final index;
  DetailScreen({Key key, @required this.kerjaan, @required this.fungsi, @required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Desktripsi'),
        ),
      body: TextFormField(
        initialValue: '${kerjaan.address}',
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
        hintText: 'nyuci baju pake mesin cuci', labelText: 'Deskripsi'),
        onFieldSubmitted: (val) {
           Todo kerj = Todo(kerjaan.name,val,kerjaan.id,kerjaan.checked);
            fungsi(kerj, index);
            Navigator.pop(context);
          },
      ),
    );
  }
}

class DetailScreenEdit extends StatelessWidget {
  final Todo kerjaan;
  final index;
  final fungsi;
  DetailScreenEdit({Key key,@required this.kerjaan, this.fungsi, this.index}): super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Ganti Judul Kerjaan')
      ),
      body: TextFormField(
        initialValue: kerjaan.name,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
        hintText: 'Nyuci Baju', labelText: 'Judul Kerjaan'),

         onFieldSubmitted: (val) {
           Todo kerj = Todo(val,kerjaan.address,kerjaan.id,kerjaan.checked);
            fungsi(kerj, index);
            Navigator.pop(context);
          },
      ),
    );
  }
}