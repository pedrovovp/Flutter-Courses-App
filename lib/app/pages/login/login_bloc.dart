import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

class LoginBloc extends BlocBase {

  StreamController _loginController = StreamController();
  Stream get loginOutput => _loginController.stream;
  Sink get loginInput => _loginController.sink;

  Map <String,String> loginList;

  saveLogin(String login, String senha){
    loginList = {"$login" : "$senha"};
    loginInput.add(loginList);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
