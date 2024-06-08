import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cmp/Notes/notes_page.dart';
import 'package:flutter/material.dart';

class Splashgif extends StatefulWidget {
  const Splashgif({Key? key}) : super(key: key);

  @override
  State<Splashgif> createState() => _SplashgifState();
}

class _SplashgifState extends State<Splashgif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Center(
            child: SizedBox(
              height: 300,
              width: 400,
              child: AnimatedSplashScreen(
                splash: Image.asset('assets/Preloader IV.gif'),
                nextScreen: const NotesPage(),
                splashTransition: SplashTransition.sizeTransition,
                splashIconSize: 100,
                backgroundColor: Colors.black,
                duration: 6000,
                // seconds: 8,
                // backgroundColor: Colors.black,
                // image: Image.asset('assets/Preloader IV.gif'),
                // loaderColor: Colors.white,
                // loadingText: const Text("Welcome To BhaBhaNotes"),
                // navigateAfterSeconds: NotesPage(),
              ),
            ),
          ),
          const Spacer(),
          text(),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

Widget text() => Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText("BHABHA Technology's",
                textStyle: const TextStyle(fontSize: 20), speed: const Duration(milliseconds: 350)),
          ],
        ),
      ),
    );
