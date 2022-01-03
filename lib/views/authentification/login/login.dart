import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_app/views/tab_containter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();

  static const String routeName = "/login";
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                      "Barberino",
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
                                    text: "Privatkunde",
                                    icon: Icon(Icons.person),
                                  ),
                                  Tab(
                                    text: "Friseur",
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
                    child: Text("Noch kein Account? Dann hier registrieren"),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget buildTabs(int flag, GlobalKey<FormState> _passedFormKey) {
    return Form(
      child: Container(
        // decoration: BoxDecoration(
        //     border: Border.all(
        //         color: Colors.deepOrange, width: 4)),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: TextField(
                decoration: InputDecoration(
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
                  onPressed: () => {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ContainerPage(title: "SaloonApp")))
                      },
                  child: Text("Login")),
            ),
          ],
        ),
      ),
    );
  }
}
