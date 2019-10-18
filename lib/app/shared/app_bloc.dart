import 'dart:async';
import 'package:app/app/pages/login/login_page.dart';
import 'package:app/app/shared/validator.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends Object with Validators implements BlocBase {
  
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _changeController = BehaviorSubject<int>();

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password => _passwordController.stream.transform(passwordValidator);
  Stream<int> get changeOutput => _changeController.stream;

  Stream<bool> get submitCheck => Observable.combineLatest2(email, password, (e,p) => true);
  
  Function(String) get emailInput => _emailController.sink.add;
  Function(String) get passwordInput => _passwordController.sink.add;
  Sink get changeInput => _changeController.sink;

  changeLogin(int loginState){
    if(loginState == 1)
      loginState = 0;
    else if(loginState == 0)
      loginState = 1;
    changeInput.add(loginState);
  }

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
}
