import 'package:flutter/material.dart';
import 'package:saloon_app/providers/theme_provider.dart';
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
    return Consumer(
        builder: (context, ref, _) => MaterialApp(
              title: 'Flutter Demo',
              theme: ref.watch(theme),
              darkTheme: ref.watch(darkTheme),
              themeMode: ref.watch(changeTheme).darkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
              /* ThemeMode.system to follow system theme, 
         ThemeMode.light for light theme, 
         ThemeMode.dark for dark theme
      */
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
            ));
  }
}
