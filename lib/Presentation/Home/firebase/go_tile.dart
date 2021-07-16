import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goandgo/models/go.dart';

class GoTile extends StatelessWidget {
  final Go? go;
  GoTile({this.go});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.brown[go!.strength!],
                ),
                title: Text(go!.name!),
                subtitle: Text('Take ${go!.sugars!} Sugars(s)'))));
  }
}
