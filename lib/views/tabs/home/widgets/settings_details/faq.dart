import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);
  static const String routeName = "/faq";

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  List<bool> expandedList = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Questions and Answers")),
      body: SingleChildScrollView(
        child: SizedBox(
          // height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "FAQ",
                      style: GoogleFonts.irishGrover(),
                      textScaleFactor: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  // color: Colors.green,
                  child: ExpansionPanelList(
                    expandedHeaderPadding: const EdgeInsets.all(8),
                    animationDuration: const Duration(milliseconds: 1000),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'How can I hide my profile picture ?',
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        },
                        body: ListTile(
                          title: Text(
                              'You can hide your profile picture by going to settings -> Privacy - There, make sure that the toggled is not switched',
                              style: TextStyle(color: Colors.black)),
                        ),
                        isExpanded: expandedList[0],
                        canTapOnHeader: true,
                      ),
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'How can I start a chat ?',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                        body: ListTile(
                          title: Text(
                              'In the AppBar, there is a plus sign. Clicking on that, you get a list of all your contacts. Everyone, who has also registered for the app, does have a writing icon on the right side. Clicking on that, you can start a new chat.',
                              style: TextStyle(color: Colors.black)),
                        ),
                        isExpanded: expandedList[1],
                        canTapOnHeader: true,
                      ),
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'There is a problem with the app. Can I report this somewhere?',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                        body: ListTile(
                          title: Text(
                              'In Settings, at the bottom, there is a "Bug" field. Clicking on that, you enter your email and your found bug. After that you submit it and our team will have a look on that as soon as possible',
                              style: TextStyle(color: Colors.black)),
                        ),
                        isExpanded: expandedList[2],
                        canTapOnHeader: true,
                      ),
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'Can I delete a messages?',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                        body: ListTile(
                          title: Text(
                              'For now, you cant. But soon you will have the option.',
                              style: TextStyle(color: Colors.black)),
                        ),
                        isExpanded: expandedList[3],
                        canTapOnHeader: true,
                      ),
                    ],
                    dividerColor: Colors.grey,
                    expansionCallback: (panelIndex, isExpanded) {
                      expandedList[panelIndex] = !expandedList[panelIndex];
                      setState(() {});
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
