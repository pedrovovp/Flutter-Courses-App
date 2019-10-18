import 'package:app/app/pages/home/home_module.dart';
import 'package:app/app/pages/login/login_module.dart';
import 'package:app/app/pages/register/register_bloc.dart';
import 'package:flutter/material.dart';

RegisterBloc bloc = RegisterBloc(); 

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

TextEditingController emailCtrl,passCtrl = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[ 
          buildInput(),
          buildButton(),
        ],
      ),
    );
  }
}

class buildInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class buildButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text(
              'Cadastrar',
            ),
            color: Colors.blue,
            onPressed: () {
                var user = emailCtrl.text;
                var pass = passCtrl.text;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginModule())
                );
            },
          ),
          FlatButton(
            child: Text('Clique para fazer login'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}