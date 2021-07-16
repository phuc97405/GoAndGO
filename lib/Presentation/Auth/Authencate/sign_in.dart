import 'package:flutter/material.dart';
import 'package:goandgo/Presentation/Auth/services/auth.dart';
import 'package:goandgo/Shared/constants.dart';
import 'package:goandgo/Shared/loadinng.dart';
import 'package:goandgo/Shared/primary_button.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool? loading = false;

  String? email;
  String? password;
  String? error = '';
  @override
  Widget build(BuildContext context) {
    return loading!
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown,
            appBar: AppBar(
              backgroundColor: Colors.brown[200],
              elevation: 0.0,
              title: Text('Sign In'),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register'))
              ],
            ),
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                          //   child: TextButton(
                          //     child: Text('Sign In Anon'),
                          //     onPressed: () async {
                          //       dynamic result = await _auth.signInAnon();
                          //       if (result == null) {
                          //         print('sign in Error');
                          //       } else {
                          //         print('sign in $result');
                          //       }
                          //     },
                          //   ),
                          // ),
                          // Container(
                          //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                          //   child: TextButton(
                          //     child: Text('Sign out'),
                          //     onPressed: () async {
                          //       await _auth.signOut();
                          //     },
                          //   ),
                          // ),
                          Spacer(
                            flex: 2,
                          ),
                          TextFormField(
                            decoration: textInputDeecoration.copyWith(
                                hintText: 'Email'),
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          TextFormField(
                            obscureText: true,
                            validator: (value) => value!.isEmpty
                                ? 'Enter a password 6+ chars long'
                                : null,
                            decoration: textInputDeecoration.copyWith(
                                hintText: 'Password'),
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          PrimaryButton(
                              text: 'Sign In',
                              press: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      _auth.signInWithEmailAndPassword(
                                          email!, password!);
                                  if (result == null) {
                                    setState(() {
                                      error = 'Account errr';
                                      loading = false;
                                    });
                                  } else {
                                    setState(() {
                                      loading = false;
                                      error = '';
                                    });
                                  }
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
                      ),
                    ))),
          );
  }
}
