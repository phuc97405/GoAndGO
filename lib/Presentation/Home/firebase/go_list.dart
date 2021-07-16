import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:goandgo/Presentation/Auth/services/auth.dart';
import 'package:goandgo/models/go.dart';
import 'package:provider/provider.dart';

import 'go_tile.dart';

class GoList extends StatefulWidget {
  @override
  GoListState createState() => GoListState();
}

class GoListState extends State<GoList> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final gos = Provider.of<List<Go>>(context);

    return ListView.builder(
        itemCount: gos.length,
        itemBuilder: (context, index) {
          return GoTile(go: gos[index]);
        });

    // gos.forEach((go) {
    //   print(go.name);
    //   print(go.strength);
    //   print(go.sugars);
    // });
    // return Center(
    //     child: TextButton(
    //   onPressed: () {
    //     _auth.signOut();
    //   },
    //   child: Container(
    //     child: Text('Sign Out'),
    //   ),
    // ));
  }
}
