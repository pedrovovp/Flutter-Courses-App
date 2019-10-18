import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';

class RegisterBloc extends BlocBase {
  StreamController<Map> _regController = BehaviorSubject();
  Stream<Map> get regOutput => _regController.stream;
  Sink<Map> get regInput => _regController.sink;

  Map<String, String> loginList;

  saveUser(String email, String pass) {
    loginList = {"email": "$email", "pass": "$pass"};
    regInput.add(loginList);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
