import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: LoginPage(),)
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  LoginProcess createState() {
    return LoginProcess();
  }
}
int choice = 0;
class LoginProcess extends State<LoginPage>{
  

bool _isUsername = true;
bool _isPassword = true;
bool _isLoginClicked = false;

String password = '';
String username = '';

  void tombolLoginPressed(){
    setState(() {
      if (username == 'Luthfi') {
        _isUsername = true;
      } else {
        _isUsername = false;
      }
      if (password == 'jancuk') {
        _isPassword = true;
      } else {
        _isPassword = false;
      }
      _isLoginClicked = true;
      if(_isLoginClicked)
      {
        if(_isPassword&&_isUsername)
        {
          choice = 4;
        }
        else{
          choice = 3;
        }
      }
      else{
        choice = 0;
      }
      print('name $_isUsername pass $_isPassword');
    });
  }
  void submitPassword(String pass){
    setState(() {
      password = pass;
      print(password);
    });
  }
  void submitUsername(String name){
    setState(() {
      username = name;
      print(username);
    });
  }
  @override
  Widget build(BuildContext context) {
    return 
    ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'asset/splash_screen.png'),
              fit: BoxFit.fitWidth,
            ),
            shape: BoxShape.rectangle,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),  
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              width: MediaQuery.of(context).size.width,
              child: Material(
                shadowColor: Colors.white,
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[ 
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0,10.0,0.0,0.0),
                    child: _choiceText(),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width*3/4,
                    child: Column(children: <Widget>[
                      TextField(    
                        style: TextStyle(color: Colors.black),
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                        onChanged: (name) => submitUsername(name),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        onChanged: (pass) => submitPassword(pass),
                      ),
                    ],),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.fromLTRB(0.0,10.0,8.0,10.0),
                    child: 
                    Text(
                      'forgot Password?',
                      style: TextStyle(fontSize: 16,color: Colors.blue),
                    ), 
                  ),
                  
              ],),),      
            ),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.fromLTRB(0, 20, 30, 0),
              child: 
              Material(
                shadowColor: Colors.white,
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                child: 
                RaisedButton(
                  elevation: 0,
                  color: Colors.white,
                  onPressed: () => tombolLoginPressed(),
                  child: Text('Login',style: TextStyle(fontSize: 28),),
                ),
              )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              width: MediaQuery.of(context).size.width,
              child: Material(
                shadowColor: Colors.white,
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Image(image: AssetImage('asset/facebook.png'),height: 40,),
                  Image(image: AssetImage('asset/google.png'),height: 40,),
                  Image(image: AssetImage('asset/linkedin.png'),height: 40,),
                  Image(image: AssetImage('asset/twitter.png'),height: 40,),
                ],),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              width: MediaQuery.of(context).size.width,
              child: Material(

                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent,
                child: 
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                  Text(
                      'New User?  ',
                      style: TextStyle(fontSize: 16,color: Colors.white),
                  ), 
                  Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16,color: Colors.blue),
                  ), 
                  Spacer(),
                ],)
              ),
            ),
            // BlueBox(),
          ],),
        ),


      ],
    );
  }  
}

Widget _choiceText() {
  Widget hasil;
  if(choice == 0){
    hasil = Text(
      'Login',
      style: TextStyle(fontSize: 28),
    );
  } 
  else if(choice == 3){
    hasil = Text(
      'Username atau Password Salah',
      style: TextStyle(fontSize: 18,color: Colors.red),
    );
  }
  else if(choice == 4){
    hasil = Text(
      'Login Berhasil',
      style: TextStyle(fontSize: 28,color: Colors.green),
    );
  }
  return hasil;
}

// Widget build(BuildContext context) {
//   return new Container(child: _buildChild());
// }
