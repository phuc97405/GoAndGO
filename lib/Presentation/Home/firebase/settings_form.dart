import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goandgo/Presentation/Auth/services/database.dart';
import 'package:goandgo/Shared/constants.dart';
import 'package:goandgo/Shared/loadinng.dart';
import 'package:goandgo/models/user.dart';
import 'package:provider/provider.dart';

class SettingFrom extends StatefulWidget {
  @override
  _SettingFromState createState() => _SettingFromState();
}

class _SettingFromState extends State<SettingFrom> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Update your Go settings',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userData!.name,
                      decoration: textInputDeecoration,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField(
                      decoration: textInputDeecoration,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem<String>(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      value: _currentSugars ?? userData.sugars,
                      onChanged: (val) {
                        setState(() {
                          _currentSugars = val.toString();
                        });
                      },
                    ),
                    Slider(
                      value:
                          (_currentStrength ?? userData.strength)!.toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength!],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength!],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                    ),
                    TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentSugars ?? userData.sugars!,
                                _currentName ?? userData.name!,
                                _currentStrength ?? userData.strength!);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
