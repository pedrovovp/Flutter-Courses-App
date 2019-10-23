import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app/app/shared/app_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login_json.dart';

AppBloc appBloc = AppBloc();
TextEditingController emailCtrl = TextEditingController(text: '');
TextEditingController passCtrl = TextEditingController(text: '');
TextEditingController nameCtrl = TextEditingController(text: '');

String emailSaved, passSaved, nameSaved;

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
          BuildButtons(),
        ],
      ),
    );
  }
}

class BuildInputLogin extends StatelessWidget {
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

class BuildInputRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: nameCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
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
            padding: const EdgeInsets.all(4.0),
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

class BuildButtons extends StatefulWidget {

  var users = new List<UserList>();
  @override
  _BuildButtonsState createState() => _BuildButtonsState();
}

class _BuildButtonsState extends State<BuildButtons> {


  changePage(BuildContext context) {
   Navigator.pushReplacementNamed(
        context, "/home");
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.users));
  }

  Future load() async{
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');    

    if (data != null) {
      Iterable decode = jsonDecode(data);
      List <UserList> result = decode.map((x) => UserList.fromJson(x)).toList();
        widget.users = result;        
    }
  }

  saveUser() {
    
    widget.users.add(
      UserList(
        name: nameCtrl.text,
        email: emailCtrl.text,
        password: passCtrl.text,
      ),
    );
    nameCtrl.clear();
    emailCtrl.clear();
    passCtrl.clear();
    save();
    appBloc.changeLogin(1);
  }

  loadUser() async {
    await load();
    for(int i = 0; i < widget.users.length; i++)
    {
      final item = widget.users[i];
      if(item.email == "${emailCtrl.text}" && item.password == "${passCtrl.text}")
      {
        emailSaved = emailCtrl.text;
        nameSaved = item.name;
        emailCtrl.clear();
        passCtrl.clear();
        changePage(context);
        break; 
      }
    }
    
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
                  BuildInputLogin(),
                  StreamBuilder<bool>(
                      stream: appBloc.submitCheck,
                      builder: (context, snapshot) {
                        return RaisedButton(
                          child: Text(
                            'Entrar',
                          ),
                          color: Colors.lightBlue,
                          onPressed: snapshot.hasData
                              ? () => loadUser()
                              : null,
                        );
                      }),
                  FlatButton(
                    child: Text('Não possui uma conta ? Clique para cadastrar'),
                    onPressed: () {
                      appBloc.changeLogin(snapshot.data);
                      emailCtrl.clear();
                      passCtrl.clear();
                    },
                  )
                ],
              );
            }else if(snapshot.data == 1) // Register
            {
              return Column(
                children: <Widget>[
                  BuildInputRegister(),
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
                      nameCtrl.clear();
                      emailCtrl.clear();
                      passCtrl.clear();
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
