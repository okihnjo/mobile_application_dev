import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Premium extends StatefulWidget {
  const Premium({Key? key}) : super(key: key);
  static const String routeName = "/premium";
  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey, Colors.black45])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text("Premium"),
              // centerTitle: true,
            ),
            body: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Soon available',
                      style: GoogleFonts.irishGrover(),
                      textScaleFactor: 2,
                    )),
                Center(child: Lottie.asset('assets/93809-moon.json'))
              ],
            )));
  }
}
