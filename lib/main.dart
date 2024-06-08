import 'package:cmp/Notes/notes_page.dart';
import 'package:cmp/screens/Onboradingscreen.dart';
import 'package:cmp/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

var initScreen;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BhaBhaNotes',
          theme: ThemeData.dark(),
          initialRoute: initScreen == 0 || initScreen == null ? 'onboard' : 'note',
          routes: {
            'note': (context) => const NotesPage(),
            'onboard': (context) => const OnboardingScreen(),
          }
          // home: const OnboardingScreen(),
          ),
    );
  }
}
