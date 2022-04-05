import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectotest/main.dart';
import 'package:proyectotest/profile_screen.dart';
import 'package:proyectotest/screens/screens.dart';
import 'package:proyectotest/screens/visualizacion.dart';

class ScreenPrincipal extends StatefulWidget {
  const ScreenPrincipal({Key? key}) : super(key: key);

  @override
  State<ScreenPrincipal> createState() => _ScreenPrincipalState();
}

class _ScreenPrincipalState extends State<ScreenPrincipal> {
  int SelectDrawerItem = 0;
  _getDrawerWidtget(int pos) {
    switch (pos) {
      case 0:
        return TaskCheckList();
      case 1:
        return VisualizacionFb();
      case 2:
        return HomePage();
    }
  }

  onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      SelectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text("Menu Principal"),
      ),
      drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  accountName: Text("Mantenimiento"),
                  accountEmail: Text("Mantenimiento"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 10, 45, 75),
                    child: Text(
                      "M",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  )),
              ListTile(
                selected: (0 == SelectDrawerItem),
                title: Text("Tareas", style: TextStyle(color: Colors.white)),
                leading: Icon(
                  Icons.task_sharp,
                  color: Colors.white,
                ),
                onTap: () {
                  onSelectItem(0);
                },
              ),
              ListTile(
                selected: (1 == SelectDrawerItem),
                title: Text("Tareas Hechas",
                    style: TextStyle(color: Colors.white)),
                leading: Icon(
                  Icons.task_alt_outlined,
                  color: Colors.white,
                ),
                onTap: () {
                  onSelectItem(1);
                },
              ),
              SizedBox(
                height: 450.0,
              ),
              ListTile(
                title: Text("Salir", style: TextStyle(color: Colors.white)),
                contentPadding: EdgeInsets.all(20),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                onTap: () {
                  onSelectItem(2);
                },
              )
            ],
          )),
      resizeToAvoidBottomInset: false,
      body: _getDrawerWidtget(SelectDrawerItem),
    );
  }
}
