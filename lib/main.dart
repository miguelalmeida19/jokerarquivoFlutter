import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:jokerarquivo/regras.dart';

import 'joker.dart';

void main() =>
    runApp(const MaterialApp(home: Home(), debugShowCheckedModeBanner: false));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  Widget build(BuildContext context) {
    SizedBox espaco = const SizedBox(
      height: 30,
    );

    return NeumorphicApp(
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        baseColor: Color(0xFF574ACE),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Joker Arquivo.pt',
      home: Scaffold(
          body: Container(
        color: const Color(0xFF5E78BD),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(55)),
                  color: Colors.transparent),
              child: Image.asset('assets/img/logo.png', scale: 1.2,),
            ),
            espaco,
            AnimatedButton(
              color: Color(0xFF4D62D0),
              child: Text(
                'COMEÇAR',
                style: GoogleFonts.getFont(
                  'IBM Plex Sans Thai',
                  fontSize: 30,
                  textStyle: TextStyle(color: Colors.white),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Joker()));
              },
            ),
            espaco,
            AnimatedButton(
              color: Color(0xFF8699FF),
              child: Text(
                'REGRAS',
                style: GoogleFonts.getFont(
                  'IBM Plex Sans Thai',
                  fontSize: 30,
                  textStyle: TextStyle(color: Colors.white),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Regras()));
              },
            ),
          ],
        ),
      )),
    );
  }
}
