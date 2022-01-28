import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bugs extends StatefulWidget {
  const Bugs({Key? key}) : super(key: key);
  static const String routeName = "/bugs";
  @override
  _BugsState createState() => _BugsState();
}

class _BugsState extends State<Bugs> {
  TextEditingController mailController = new TextEditingController();
  TextEditingController bugController = new TextEditingController();
  double opacityLevel = 0.0;
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacityLevel = 1;
      });
    });
  }

  void sendBug() {
  
    
      FirebaseFirestore.instance.collection("reports").doc().set({
        'email': mailController.text,
        'bugDescription': bugController.text,
        'createdAt': Timestamp.now()
      });
      bugController.clear();
      mailController.clear();
    
  }

  @override
  Widget build(BuildContext context) {
    print("wie oft werde ich ausgeführt");
    return Scaffold(
      appBar: AppBar(title: Text("Report a problem")),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(4),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(children: [
                AnimatedOpacity(
                  curve: Curves.fastOutSlowIn,
                  opacity: opacityLevel,
                  duration: const Duration(seconds: 1),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Welcome to our chat App. Because of the fact that the app is in the early stage, there might occur some bugs. We want you to experience a bugfree app, so by your reports, you can help us to make your experience better',
                      style: GoogleFonts.alice(),
                      textScaleFactor: 1.4,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: opacityLevel,
                  duration: const Duration(seconds: 3),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: mailController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your Email adress',
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: opacityLevel,
                  duration: const Duration(seconds: 3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: bugController,
                            onChanged: (value) {},
                            keyboardType: TextInputType.multiline,
                            minLines:
                                5, //Normal textInputField will be displayed
                            maxLines: 5, // when u
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Description of your Bug',
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title:
                                        const Text('How to write a bug report'),
                                    content: const Text(
                                        'Please be as specific as you can. Describe what you wanted to do and what actually happend.'),
                                    actions: <Widget>[
                                      // TextButton(
                                      //   onPressed: () =>
                                      //       Navigator.pop(context, 'Cancel'),
                                      //   child: const Text('Cancel'),
                                      // ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('Got it'),
                                      ),
                                    ],
                                  ),
                                ),
                            icon: Icon(Icons.info_outline))
                      ],
                    ),
                  ),
                ),
              ]),
              Container(
                child: AnimatedOpacity(
                    opacity: opacityLevel,
                    duration: const Duration(seconds: 3),
                    child: TextButton.icon(
                      onPressed: () {
                        if (mailController.text.length > 4 || bugController.text.length > 1) {
                        sendBug();
                        final snackBar = const SnackBar(
                            content: Text('Thank you for your report!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else{
                        return null;
                      }},
                      label: const Icon(Icons.send),
                      icon: const Text("Send"),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
