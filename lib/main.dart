import 'package:flutter/material.dart';
import 'package:saloon_app/views/authentification/login/login.dart';
import 'package:saloon_app/views/tabs/chat/chat_screen.dart';
import 'package:saloon_app/views/tabs/chat/widgets/in_chat_screen/in_chat_screen.dart';
import 'package:saloon_app/views/tabs/home/settings_screen.dart';
import 'package:saloon_app/views/tab_containter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String pageName = "HomeScreen";

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return ContainerPage(
                title: 'Hello User',
              );
            }
            return Login();
          }),
      routes: {
        Login.routeName: (ctx) => const Login(),
        '/chat': (ctx) => const InChatScreen(),
        ContainerPage.routeName: (ctx) =>
            ContainerPage(title: 'Flutter Demo Home Page')
      },
      // initialRoute: Login.routeName,
    );
  }
}
