import 'package:flutter/material.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validate/validate.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}
class _LoginData {
  String username = '';
  String password = '';
}
class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _LoginData _data = _LoginData();
  String _validateAlphaNumeric(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isAlphaNumeric(value);
      //Validate.isEmail(value);
    } catch (e) {
      return 'No symbol cuk';
    }
    return null;
  }
  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }
    return null;
  }
  submit(BuildContext context) async{
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      print('Printing the login data.');
      print('Username: ${_data.username}');
      print('Password: ${_data.password}');
      if (_data.username == "LuthfiHalim" &&
          _data.password == "123123123") {
        final snackBar = SnackBar(
          content: Text('Ready to Go'),
          backgroundColor: Colors.blue,
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        // Find the Scaffold in the widget tree and use
        // it to show a SnackBar.
        final simpanData = await SharedPreferences.getInstance();
        simpanData.setString('token', _data.username);
        _scaffoldKey.currentState.showSnackBar(snackBar);
        Navigator.pushReplacementNamed(context, Pages.Home);
      } 
      else {
        final snackBar = SnackBar(
          content: Text('Upsy doopsy!'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        // Find the Scaffold in the widget tree and use
        // it to show a SnackBar.
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }
  textDivider() => Row(children: <Widget>[
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              )),
        ),
        Text("Social Login"),
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              )),
        ),
      ]);
  loginForm() => Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.topLeft,
              ),
              TextFormField(
                  keyboardType: TextInputType
                      .emailAddress, // Use email input type for emails.
                  decoration: InputDecoration(
                      hintText: 'BudiSetiawan', labelText: 'Username'),
                  validator: this._validateAlphaNumeric,
                  onSaved: (String value) {
                    this._data.username = value;
                  }),
              TextFormField(
                  obscureText: true, // Use secure text for passwords.
                  decoration: InputDecoration(
                      hintText: 'Password', labelText: 'Password'),
                  validator: this._validatePassword,
                  onSaved: (String value) {
                    this._data.password = value;
                  }),
              Container(
                margin: EdgeInsets.only(top: 15.0, bottom: 20.0),
                child: Text(
                  'Forgot Password?',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.blue),
                ),
                alignment: Alignment.bottomRight,
              )
            ],
          ),
        ),
      );
  loginButton(BuildContext context) => Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.only(top: 20, right: 0),
        margin: EdgeInsets.only(bottom: 20, top: 20),
        child: RaisedButton(
          elevation: 5,
          textColor: Colors.white,
          padding: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
              width: 150,
              height: 50,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 148, 231, 225),
                      Color.fromARGB(255, 62, 182, 226)
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                'Login',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          onPressed: () => submit(context),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: this._formKey,
            child: ListView(
              children: <Widget>[
                // Image(
                //   image: AssetImage(''),
                //   height: 150,
                //   fit: BoxFit.contain,
                // ),
                loginForm(),
                loginButton(context),
                textDivider(),
                Container(
                  height: 150,
                  width: 150,
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage(''),
                  //         fit: BoxFit.fill)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image(
                            image: AssetImage('asset/facebook1.png'),
                            height: 36,
                          ),
                          Image(
                            image: AssetImage('asset/google1.png'),
                            height: 36,
                          ),
                          Image(
                            image: AssetImage('asset/linkedin1.png'),
                            height: 36,
                          ),
                          Image(
                            image: AssetImage('asset/twitter.png'),
                            height: 36,
                          )// Logo image social media
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'New User? Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}