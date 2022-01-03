import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_app/views/tab_containter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();

  static const String routeName = "/login";
  // final email = TextEditingController();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final passwordController = TextEditingController();

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
                              const TabBar(
                                indicatorColor: Colors.green,
                                labelColor: Colors.red,
                                tabs: <Widget>[
                                  Tab(
                                    text: "Privat person",
                                    icon: Icon(Icons.person),
                                  ),
                                  Tab(
                                    text: "Company",
                                    icon: Icon(Icons.architecture_sharp),
                                  )
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: <Widget>[
                                    buildTabs(0, _formKey),
                                    buildTabs(1, _formKey)
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Center(
                    child: Text("Already have an account? LogIn!"),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget buildTabs(int flag, GlobalKey<FormState> _passedFormKey) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(
      //         color: Colors.deepOrange, width: 4)),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: TextField(
                controller: email,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Username',
                  prefixIcon: Icon(Icons.email),
                )),
          ),
          if (flag != 0)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.post_add_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Postalcode',
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.password_sharp),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: 'Password',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            // color: Colors.red,
            width: 320,
            // alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  signIn(email.text, passwordController.text);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ContainerPage(title: "SaloonApp")));
                },
                // onPressed: () => {
                //       // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //       //     builder: (BuildContext context) =>
                //       //         ContainerPage(title: "SaloonApp")))
                //       print(email.text + " und PW" + passwordController.text)
                //     },
                child: Text("SignUp")),
          ),
        ],
      ),
    );
  }
}
