import 'package:app/app/pages/home/home_module.dart';
import 'package:app/app/pages/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:app/app/shared/app_bloc.dart';

RegisterBloc regBloc = RegisterBloc();
AppBloc appBloc = AppBloc();
TextEditingController emailCtrl = TextEditingController(text: '');
TextEditingController passCtrl = TextEditingController(text: '');
String emailSaved, passSaved;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<int>(
          stream: appBloc.changeOutput,
          initialData: 0,
          builder: (context, snapshot) {
            if(snapshot.data == 0)
              return Text("Login");
            else if(snapshot.data == 1)
              return Text("Cadastrar");
          }
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          BuildInput(),
          BuildButtons(),
        ],
      ),
    );
  }
}

class BuildInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<String>(
                stream: appBloc.email,
                builder: (context, snapshot) {
                  return TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailCtrl,
                    onChanged: appBloc.emailInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      errorText: snapshot.error,
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<String>(
                stream: appBloc.password,
                builder: (context, snapshot) {
                  return TextField(
                    keyboardType: TextInputType.text,
                    onChanged: appBloc.passwordInput,
                    controller: passCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                      errorText: snapshot.error,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}


class BuildButtons extends StatelessWidget {
  
  RegisterBloc regBloc = RegisterBloc();

  changePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeModule()));
  }
  saveUser() {
    regBloc.saveUser(emailCtrl.text, passCtrl.text);
    emailCtrl.clear();
    passCtrl.clear();
    appBloc.changeLogin(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<int>(
          stream: appBloc.changeOutput,
          initialData: 0,
          builder: (context, snapshot) {
            if (snapshot.data == 0) { // Login
              return Column(
                children: <Widget>[
                  StreamBuilder<bool>(
                      stream: appBloc.submitCheck,
                      builder: (context, snapshot) {
                        return RaisedButton(
                          child: Text(
                            'Entrar',
                          ),
                          color: Colors.lightBlue,
                          onPressed: snapshot.hasData
                              ? () => changePage(context)
                              : null,
                        );
                      }),
                  FlatButton(
                    child: Text('Não possui uma conta ? Clique para cadastrar'),
                    onPressed: () {
                      appBloc.changeLogin(snapshot.data);
                    },
                  )
                ],
              );
            }else if(snapshot.data == 1) // Register
            {
              return Column(
                children: <Widget>[
                  StreamBuilder<bool>(
                      stream: appBloc.submitCheck,
                      builder: (context, snapshot) {
                        return RaisedButton(
                          child: Text(
                            'Cadastrar',
                          ),
                          color: Colors.lightBlue,
                          onPressed: snapshot.hasData
                              ? () => saveUser()
                              : null,
                        );
                      }),
                  FlatButton(
                    child: Text('Clique para fazer login'),
                    onPressed: () {
                      appBloc.changeLogin(snapshot.data);
                    },
                  )
                ],
              );
            }
          }),
    );
  }
}
