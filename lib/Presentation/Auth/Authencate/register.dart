import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goandgo/Presentation/Auth/services/auth.dart';
import 'package:goandgo/Shared/constants.dart';
import 'package:goandgo/Shared/loadinng.dart';
import 'package:goandgo/Shared/primary_button.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? error = '';

  bool? loading = false;
  @override
  Widget build(BuildContext context) {
    return loading!
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Register'),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Sign In'))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'Enter an Email' : null,
                        decoration:
                            textInputDeecoration.copyWith(hintText: 'Email'),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (value) => value!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        decoration:
                            textInputDeecoration.copyWith(hintText: 'Password'),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      PrimaryButton(
                          text: 'Register',
                          press: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email!, password!);

                              print(email!.toString() + password!.toString());
                              if (result == null) {
                                setState(() {
                                  loading = true;

                                  error = 'Email khong dung';
                                });
                              } else
                                setState(() {
                                  loading = true;
                                  error = '';
                                });
                            }
                          }),
                      SizedBox(
                        height: 12,
                        child: Text(
                          error.toString(),
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                    ],
                  )),
            ),
          );
  }
}
