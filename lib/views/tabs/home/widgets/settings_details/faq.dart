import 'package:flutter/material.dart';

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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text("FAQ"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.green,
                  child: ExpansionPanelList(
                    expandedHeaderPadding: EdgeInsets.all(8),
                    animationDuration: Duration(milliseconds: 1000),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'Click To Expand',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                        body: ListTile(
                          title: Text('Description text',
                              style: TextStyle(color: Colors.black)),
                        ),
                        isExpanded: expandedList[0],
                        canTapOnHeader: true,
                      ),
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'Click To Expand',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                        body: ListTile(
                          title: Text('Description text',
                              style: TextStyle(color: Colors.black)),
                        ),
                        isExpanded: expandedList[1],
                        canTapOnHeader: true,
                      ),
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'Click To Expand',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                        body: ListTile(
                          title: Text('Description text',
                              style: TextStyle(color: Colors.black)),
                        ),
                        isExpanded: expandedList[2],
                        canTapOnHeader: true,
                      ),
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'Click To Expand',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                        body: ListTile(
                          title: Text('Description text',
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
