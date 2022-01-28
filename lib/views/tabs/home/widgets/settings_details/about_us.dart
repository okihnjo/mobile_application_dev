import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return IconButton(
        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
        icon: FaIcon(FontAwesomeIcons.gamepad),
        onPressed: () {
          print("Pressed");
        });
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);
  static const String routeName = "/aboutUs";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Who we are"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/images/okan.png'),
                      // backgroundColor: Colors.transparent,
                    ),
                    title: Text('Okan Coskun'),
                    subtitle: Text(
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,'),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: ListTile(
                              minLeadingWidth: 10,
                              // isThreeLine: true,
                              title: Text("Frontend-Developer", maxLines: 1),
                              leading: FaIcon(FontAwesomeIcons.suitcase)),
                        ),
                        Flexible(
                          flex: 1,
                          child: ListTile(
                              minLeadingWidth: 10,
                              // isThreeLine: true,
                              title: Text("Izmir"),
                              leading: FaIcon(FontAwesomeIcons.locationArrow)),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                          flex: 2,
                          child: ListTile(
                              minLeadingWidth: 10,
                              // isThreeLine: true,
                              title: Text("okancoskun@gmx.de"),
                              leading: FaIcon(FontAwesomeIcons.mailBulk))),
                      Flexible(
                        child: ListTile(
                            minLeadingWidth: 10,
                            // isThreeLine: true,
                            title: Text("+1 234 567 8"),
                            leading: FaIcon(FontAwesomeIcons.phone)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 2,
                        child: ListTile(
                            minLeadingWidth: 2,
                            // isThreeLine: true,
                            title: Text("Okihnjo"),
                            leading: FaIcon(FontAwesomeIcons.github)),
                      ),
                      Flexible(
                        flex: 1,
                        child: ListTile(
                            minLeadingWidth: 2,
                            // isThreeLine: true,
                            title: Text("Okihnjo"),
                            leading: FaIcon(FontAwesomeIcons.stackOverflow)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('View Stack'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('View GitHub'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                         AssetImage('assets/images/Caner.png'),
                      // backgroundColor: Colors.transparent,
                    ),
                    title: Text('Caner Ünal'),
                    subtitle: Text(
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,'),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: ListTile(
                              minLeadingWidth: 10,
                              // isThreeLine: true,
                              title: Text("Frontend-Developer", maxLines: 1),
                              leading: FaIcon(FontAwesomeIcons.suitcase)),
                        ),
                        Flexible(
                          flex: 1,
                          child: ListTile(
                              minLeadingWidth: 10,
                              // isThreeLine: true,
                              title: Text("Izmir"),
                              leading: FaIcon(FontAwesomeIcons.locationArrow)),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                          flex: 2,
                          child: ListTile(
                              minLeadingWidth: 10,
                              // isThreeLine: true,
                              title: Text("caneruenal@gmail.com"),
                              leading: FaIcon(FontAwesomeIcons.mailBulk))),
                      Flexible(
                        child: ListTile(
                            minLeadingWidth: 10,
                            // isThreeLine: true,
                            title: Text("+1 234 567 8"),
                            leading: FaIcon(FontAwesomeIcons.phone)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 2,
                        child: ListTile(
                            minLeadingWidth: 2,
                            // isThreeLine: true,
                            title: Text("C4n3r"),
                            leading: FaIcon(FontAwesomeIcons.github)),
                      ),
                      Flexible(
                        flex: 1,
                        child: ListTile(
                            minLeadingWidth: 2,
                            // isThreeLine: true,
                            title: Text("NA"),
                            leading: FaIcon(FontAwesomeIcons.stackOverflow)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('View Stack'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('View GitHub'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
