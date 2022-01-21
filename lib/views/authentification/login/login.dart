import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_app/views/tab_containter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();

  static const String routeName = "/login";
  // final email = TextEditingController();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> _formKeyRegistration = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final passwordController = TextEditingController();
  String _userEmail = '';
  String _username = '';
  String _userPassword = '';
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    passwordController.dispose();
    super.dispose();
  }

  signIn(String email, String password) async {
    print(email + " " + password);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 180.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 100.0)),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    child: const Icon(
                      Icons.flutter_dash,
                      size: 100,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                  // color: Colors.blueAccent,
                  height: 450,
                  child: Column(children: [
                    Text(
                      "Saloon",
                      style: GoogleFonts.irishGrover(),
                      textScaleFactor: 2,
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                onTap: (int index) => {setState(() {})},
                                indicatorColor: Colors.green,
                                labelColor: Colors.red,
                                tabs: <Widget>[
                                  Tab(
                                    text: "Login",
                                    icon: Icon(Icons.person),
                                  ),
                                  Tab(
                                    text: "Registration",
                                    icon: Icon(Icons.architecture_sharp),
                                  )
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: <Widget>[
                                    buildTabs(0, _formKey),
                                    buildTabs(1, _formKeyRegistration)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                // const Padding(
                //   padding: EdgeInsets.only(bottom: 2.0),
                //   child: Center(
                //     child: Text("Already have an account? LogIn!"),
                //   ),
                // ),
              ]),
        ),
      ),
    );
  }

  Widget buildTabs(int flag, GlobalKey<FormState> _passedFormKey) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _passedFormKey,
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: TextFormField(
                  onSaved: (value) {
                    _userEmail = value as String;
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email address"),
                )),
            if (flag != 0)
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: TextFormField(
                    onSaved: (value) {
                      _username = value as String;
                    },
                    decoration: InputDecoration(labelText: "Username"),
                  )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: TextFormField(
                onSaved: (value) {
                  _userPassword = value as String;
                },
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 7) {
                    return "Password must be at least 7 charachters long";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              // child: TextField(
              //   controller: passwordController,
              //   decoration: const InputDecoration(
              //     filled: true,
              //     prefixIcon: Icon(Icons.password_sharp),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(10))),
              //     hintText: 'Password',
              //   ),
              // ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              // color: Colors.red,
              width: 320,
              // alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () async {
                    final isValid = _passedFormKey.currentState?.validate();
                    FocusScope.of(context).unfocus();
                    if (isValid == true) {
                      _passedFormKey.currentState?.save();
                      var authResult;
                      try {
                        if (flag == 0) {
                          // call login
                          authResult = await auth.signInWithEmailAndPassword(
                              email: _userEmail, password: _userPassword);
                          print('authResult');
                        } else {
                          authResult =
                              await auth.createUserWithEmailAndPassword(
                                  email: _userEmail, password: _userPassword);

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(authResult.user.uid)
                              .set({
                            'username': _username,
                            'email': _userEmail,
                            'userId': authResult.user.uid
                          });
                        }
                      } on PlatformException catch (err) {
                        var message = "An Error occured";
                      }
                      print("everything worked");
                    }
                  },
                  //   signIn(email.text, passwordController.text);
                  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //       builder: (BuildContext context) =>
                  //           ContainerPage(title: "SaloonApp")));
                  // },
                  child: Text(flag == 0 ? "Login" : "SignIn")),
            ),
          ],
        ),
      ),
    );
  }
}
