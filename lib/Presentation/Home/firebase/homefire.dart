import 'package:flutter/material.dart';
import 'package:goandgo/Presentation/Auth/services/auth.dart';
import 'package:goandgo/Presentation/Auth/services/database.dart';
import 'package:goandgo/Presentation/Home/firebase/go_list.dart';
import 'package:goandgo/Presentation/Home/firebase/settings_form.dart';
import 'package:goandgo/models/go.dart';
import 'package:provider/provider.dart';

class HomeFire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingFrom(),
            );
          });
    }

    return StreamProvider<List<Go>>.value(
        value: DatabaseService().go,
        initialData: [],
        child: Scaffold(
            appBar: AppBar(
              title: Text('Home'),
              elevation: 0.0,
              backgroundColor: Colors.brown,
              actions: [
                TextButton.icon(
                    onPressed: () {
                      _auth.signOut();
                    },
                    icon: Icon(Icons.logout),
                    label: Text('Logout')),
                TextButton.icon(
                    onPressed: () {
                      _showSettingsPanel();
                    },
                    icon: Icon(Icons.settings),
                    label: Text('Settings'))
              ],
            ),
            body: GoList()));
  }
}
