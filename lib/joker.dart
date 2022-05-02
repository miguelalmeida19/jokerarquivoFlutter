import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class Joker extends StatefulWidget {
  const Joker({Key? key}) : super(key: key);

  @override
  State<Joker> createState() => _JokerState();
}

class _JokerState extends State<Joker> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        baseColor: Color(0xFFBD9C0A),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Joker Arquivo.pt',
      home: Scaffold(
        body: Container(
          color: const Color(0xFFFCE300),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(40)),
                    color: Colors.transparent),
                child: Image.asset('assets/img/logo.png', scale: 1.6,),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: 800,
                height: 300,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    color: const Color(0xFF4D62D0),
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Positioned(
                            left: 10,
                            child: SizedBox(
                              width: 50,
                              height: 100,
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                  color: const Color(0xFF647AEA),
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(5)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '1',
                                      style: GoogleFonts.getFont(
                                        'IBM Plex Sans Thai',
                                        fontSize: 22,
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Divider(
                                      height: 20,
                                      thickness: 5,
                                      indent: 5,
                                      endIndent: 5,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '12',
                                      style: GoogleFonts.getFont(
                                        'IBM Plex Sans Thai',
                                        fontSize: 17,
                                        textStyle: const TextStyle(
                                          color: Color(0xFFcccccc),
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 650,
                            child: Flexible(
                                child: Text(
                              'Na cidade do Porto, o que se pretende beber quando se pede um “fino”?',
                              style: GoogleFonts.getFont(
                                'IBM Plex Sans Thai',
                                fontSize: 25,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 450,
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: [
                            AnimatedButton(
                              height: 50,
                              width: 150,
                              color: const Color(0xFF647AEA),
                              child: Text(
                                'Espumante',
                                style: GoogleFonts.getFont(
                                  'IBM Plex Sans Thai',
                                  fontSize: 15,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              onPressed: () {},
                            ),
                            AnimatedButton(
                              height: 50,
                              width: 150,
                              color: const Color(0xFF647AEA),
                              child: Text(
                                'Espumante',
                                style: GoogleFonts.getFont(
                                  'IBM Plex Sans Thai',
                                  fontSize: 15,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              onPressed: () {},
                            ),
                            AnimatedButton(
                              height: 50,
                              width: 150,
                              color: const Color(0xFF647AEA),
                              child: Text(
                                'Espumante',
                                style: GoogleFonts.getFont(
                                  'IBM Plex Sans Thai',
                                  fontSize: 15,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              onPressed: () {},
                            ),
                            AnimatedButton(
                              height: 50,
                              width: 150,
                              color: const Color(0xFF647AEA),
                              child: Text(
                                'Espumante',
                                style: GoogleFonts.getFont(
                                  'IBM Plex Sans Thai',
                                  fontSize: 15,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
