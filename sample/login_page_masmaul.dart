
import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forms in Flutter',
      home: LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}
class _LoginData {
  String email = '';
  String password = '';
}
class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _LoginData _data = _LoginData();
  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address. salah cuyasdf';
    }
    return null;
  }
  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }
    return null;
  }
  submit(BuildContext context) {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
      if (_data.email == "mprambadi@gmail.com" &&
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
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
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
                      hintText: 'you@example.com', labelText: 'Username'),
                  validator: this._validateEmail,
                  onSaved: (String value) {
                    this._data.email = value;
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
                Image(
                  image: AssetImage('assets/logo.png'),
                  height: 150,
                  fit: BoxFit.contain,
                ),
                loginForm(),
                loginButton(context),
                textDivider(),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/place.png'),
                          fit: BoxFit.fill)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image(
                              image: NetworkImage(
                                  'https://cdn3.iconfinder.com/data/icons/capsocial-round/500/facebook-512.png'),
                              height: 48),
                          Image(
                              image: NetworkImage(
                                  'https://cdn4.iconfinder.com/data/icons/new-google-logo-2015/400/new-google-favicon-512.png'),
                              height: 48),
                          Image(
                              image: NetworkImage(
                                  'https://cdn1.iconfinder.com/data/icons/somacro___dpi_social_media_icons_by_vervex-dfjq/500/twitter-old.png'),
                              height: 48),
                          Image(
                              image: NetworkImage(
                                  'http://www.vectorico.com/download/social_media/LinkedIn-Icon.png'),
                              height: 48),
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