import 'package:app/app/repositories/home_repository.dart';
import 'package:app/app/shared/product_model.dart';
import 'package:flutter/material.dart';
import '../login/login_page.dart';
import 'home_bloc.dart';

HomeBloc homeBloc = HomeBloc();

class HomePage extends StatefulWidget {

  HomePage({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<ProductModel> _products = new List<ProductModel>();
  ProductRepository _repository = new ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(nameSaved),
              accountEmail: Text(emailSaved),
              onDetailsPressed: () => homeBloc.changeDetails(),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  nameSaved[0],
                  style: TextStyle(fontSize: 40),
                ),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  child: Text(
                    "B",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            StreamBuilder<bool>(
                stream: homeBloc.drawerOutput,
                initialData: false,
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return ShowUserDetails();
                  } else {
                    return ShowOptions();
                  }
                }),
            
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Cursos"),
      ),
      body: FutureBuilder(
        future: _repository.getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Text('Carregando...');
            default:
              if (snapshot.hasError)
                return new Text(snapshot.error);
              else
                return listView(context, snapshot);
          }
        }
      ),
    );
  }

Widget listView(BuildContext context, AsyncSnapshot snapshot) {
    List<ProductModel> products = snapshot.data;

    return new ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(products[index].title),
            ),
          ],
        );
      },
    );
  }

}

class ShowUserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text("Minha Conta"),
              trailing: Icon(Icons.edit),
            ),
          ListTile(
              title: Text("Sair da Conta"),
              onTap: () {
                homeBloc.changeDetails();
                Navigator.pushReplacementNamed(context, "/login");
              },
              trailing: Icon(Icons.exit_to_app),
            ),   
        ],
      ),
    );
  }
}

class ShowOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("Title 1"),
            onTap: null,
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            title: Text("Title 2"),
            onTap: null,
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            title: Text("Fechar"),
            onTap: () => Navigator.pop(context),
            trailing: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
