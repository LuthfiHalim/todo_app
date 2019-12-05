import 'package:flutter/material.dart';
void main() => runApp(Coba());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blue,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41'),
        ],
      ),
    );
    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BuildButtonComponent(color, Icons.call, 'CALL'),
          BuildButtonComponent(color, Icons.near_me, 'ROUTE'),
          BuildButtonComponent(color, Icons.share, 'SHARE'),
        ],
      ),
    );
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        """ Nulla ea duis incididunt elit consectetur anim sunt eu eiusmod cillum. Qui laboris in amet veniam. Excepteur ea veniam eiusmod ex amet ex magna tempor eiusmod qui. Lorem reprehenderit mollit est voluptate qui excepteur deserunt irure id irure deserunt sunt ad. Consequat cillum mollit nostrud ullamco.
Aliquip cupidatat sunt non sint velit cillum ullamco esse. Sit aute qui voluptate consectetur. Do officia officia commodo anim sint minim cupidatat ullamco Lorem adipisicing. Non eiusmod aliquip officia ex pariatur dolore nisi veniam eiusmod deserunt fugiat consectetur quis. Occaecat proident cupidatat enim id labore ipsum cillum magna non dolor.
Ipsum amet labore ea occaecat eiusmod amet labore aute nostrud consectetur eu anim. Qui occaecat dolore ea adipisicing. Sint anim occaecat nisi proident commodo aliqua officia cillum anim voluptate consectetur ad quis. Nisi sint exercitation magna mollit sint exercitation minim labore. Nisi aliquip laboris eiusmod qui esse reprehenderit excepteur esse. Duis ut eiusmod culpa irure irure Lorem anim eiusmod aute mollit excepteur cillum laboris.
Amet laborum cillum pariatur non in ex eu quis. Excepteur quis cillum laboris aliqua commodo velit culpa Lorem occaecat. Non deserunt duis fugiat mollit sint enim elit adipisicing. Proident quis ut anim dolore id enim ea laboris et nulla fugiat amet laboris.
Enim dolor anim anim non. Anim culpa ad Lorem duis qui dolor id sint et minim cupidatat exercitation id. Est velit ea sunt dolor. Lorem do amet amet elit id duis tempor proident veniam voluptate culpa. Laboris non sint ea amet culpa tempor occaecat mollit commodo aute minim ea.  """,
        softWrap: true,
      ),
    );
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter layout demo'),
          ),
          body: Column(
            children: <Widget>[
              Image(
                image: NetworkImage(
                    "https://cdn2.tstatic.net/jogja/foto/bank/images/wisata-jogja-hits-skip-sejenak-dari-rutinitas.jpg"),
                width: 600,
                height: 240,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    titleSection,
                    buttonSection,
                    textSection,
                  ],
                ),
              )
            ],
          )),
    );
  }
}
class Coba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ini Coba',
      home: Scaffold(
          appBar: AppBar(title: Text('ini title coba')), body: Login()),
    );
  }
}
class BuildButtonComponent extends StatelessWidget {
  final icon;
  final color;
  final label;
  BuildButtonComponent(this.color, this.icon, this.label);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}
class LoginState extends State<Login> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  String username = "";
  void handleAction() {
    setState(() {
      _isFavorited = !_isFavorited;
      if (_isFavorited) {
        _favoriteCount += 1;
      }
    });
  }
  void handleCheckbox() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }
  void handleChange(e) {
    setState(() {
      username = e;
    });
  }
  @override
  Widget build(BuildContext context) {
    return (Column(
      children: <Widget>[
        Checkbox(
          onChanged: (bool value) {
            handleCheckbox();
          },
          value: _isFavorited,
        ),
        TextField(onChanged: (e) => handleChange(e)),
        Text(username),
        Container(
          child: _isFavorited
              ? Text('ini True')
              : TestCoba(_isFavorited, _favoriteCount.toString(), handleAction),
        )
      ],
    ));
  }
}
class TestCoba extends StatelessWidget {
  final bool _isFavorited;
  final String _favoriteCount;
  final handleAction;
  TestCoba(this._isFavorited, this._favoriteCount, this.handleAction);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.ac_unit),
          onPressed: () {
            handleAction();
          },
        ),
        Text(_isFavorited ? 'ok' : "nok"),
        Text(_favoriteCount.toString())
      ],
    );
  }
}