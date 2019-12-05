import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  
  final String status;
  final Icon icon;
  final int jumlah;
  final Color warna;

  const Box({Key key, @required this.status, @required this.icon, @required this.jumlah, @required this.warna}) : super(key: key);
  
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: MediaQuery.of(context).size.height*2/10,
      child: Material(      
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(status,style: TextStyle(color: warna,fontSize: 26),),
            Icon(icon.icon,size: 38,color: warna,),
            Text(jumlah.toString(),style: TextStyle(color: warna,fontSize: 34),),
          ],
        ),
      ),
    );
  }
}
