import 'package:app/app/pages/home/home_module.dart';
import 'package:app/app/pages/home/home_page.dart';
import 'package:app/app/pages/login/login_module.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: LoginModule(),
      routes: {
        "/home" : (_) => HomeModule()
      },
    );
  }
}
