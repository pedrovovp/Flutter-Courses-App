import 'package:flutter/material.dart';
import '../login/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Pedro Vinícius"),
              accountEmail: Text(emailSaved),
              currentAccountPicture: CircleAvatar(
                backgroundColor: 
                  Theme.of(context).platform == TargetPlatform.iOS
                    ? Colors.blue
                    : Colors.white,
                child: Text(
                  "P",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            ListTile(
              title: Text("Title 1"),
              onTap: null,
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text("Title 2"),
              onTap: null,
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
