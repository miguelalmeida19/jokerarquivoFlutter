import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jokerarquivo/questions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:status_alert/status_alert.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Joker extends StatefulWidget {
  const Joker({Key? key}) : super(key: key);

  @override
  State<Joker> createState() => _JokerState();
}

class _JokerState extends State<Joker> {
  late Quiz _quiz;
  late List<Quiz> _quizes = [];
  late Quiz _atual;
  late Countdown countdown;
  bool isLoading = false;
  int roundNumber = 1;
  int maxRound = 12;

  final CountdownController _controller = CountdownController(autoStart: true);

  Future<Quiz> buildQuiz() async {
    return await getQuiz();
  }

  Future<void> buildQuizes() async {
    List<Quiz> list = [];
    for (int i = 0; i < 15; i++) {
      list.add(await getQuiz());
      setState(() {
        _quizes = list;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    buildQuizes();

    buildQuiz().then((results) {
      countdown = Countdown(
        controller: _controller,
        build: (_, double time) => Text(
          time.toString(),
          style: GoogleFonts.getFont(
            'IBM Plex Sans Thai',
            fontSize: 25,
            textStyle: const TextStyle(
              color: Colors.white,
            ),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        onFinished: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Timer is done!'),
            ),
          );
        },
        seconds: 40,
      );

      _controller.start();

      setState(() {
        _quiz = results;
        isLoading = true;
        _atual = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.start();
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
        body: isLoading
            ? Container(
                color: const Color(0xFFFCE300),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(40)),
                          color: Colors.transparent),
                      child: Image.asset(
                        'assets/img/logo.png',
                        scale: 1.6,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 800,
                      height: 330,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          color: const Color(0xFF4D62D0),
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(30)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                      color: const Color(0xFF647AEA),
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(5)),
                                    ),
                                    child: countdown,
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            roundNumber.toString(),
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
                                            maxRound.toString(),
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
                                      child: SelectableText(
                                    _atual.pergunta!,
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
                              width: 800,
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                alignment: WrapAlignment.center,
                                children: [
                                  AnimatedButton(
                                    height: 70,
                                    width: 300,
                                    color: const Color(0xFF647AEA),
                                    child: Text(
                                      _atual.opcoes![0],
                                      style: GoogleFonts.getFont(
                                        'IBM Plex Sans Thai',
                                        fontSize: 15,
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      _controller.pause();
                                      if (_atual.opcoes![0] ==
                                          _atual.respostaCerta!) {
                                        StatusAlert.show(context,
                                            duration:
                                                const Duration(seconds: 2),
                                            title: 'CERTAAAAA!',
                                            configuration:
                                                const IconConfiguration(
                                                    icon: Icons.done),
                                            backgroundColor: Colors.green
                                        );
                                        setState(() {
                                          roundNumber++;
                                          _atual = _quizes[roundNumber - 1];
                                          _controller.restart();
                                        });
                                        build(context);
                                      } else {}
                                    },
                                  ),
                                  AnimatedButton(
                                    height: 70,
                                    width: 300,
                                    color: const Color(0xFF647AEA),
                                    child: Text(
                                      _atual.opcoes![1],
                                      style: GoogleFonts.getFont(
                                        'IBM Plex Sans Thai',
                                        fontSize: 15,
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      _controller.pause();
                                      if (_atual.opcoes![1] ==
                                          _atual.respostaCerta!) {
                                        StatusAlert.show(context,
                                            duration:
                                                const Duration(seconds: 2),
                                            title: 'CERTAAAAA!',
                                            configuration:
                                                const IconConfiguration(
                                                    icon: Icons.done),
                                            backgroundColor: Colors.green);
                                        setState(() {
                                          roundNumber++;
                                          _atual = _quizes[roundNumber - 1];
                                          _controller.restart();
                                        });
                                        build(context);
                                      } else {}
                                    },
                                  ),
                                  AnimatedButton(
                                    height: 70,
                                    width: 300,
                                    color: const Color(0xFF647AEA),
                                    child: Text(
                                      _atual.opcoes![2],
                                      style: GoogleFonts.getFont(
                                        'IBM Plex Sans Thai',
                                        fontSize: 15,
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      _controller.pause();
                                      if (_atual.opcoes![2] ==
                                          _atual.respostaCerta!) {
                                        StatusAlert.show(context,
                                            duration:
                                                const Duration(seconds: 2),
                                            title: 'CERTAAAAA!',
                                            configuration:
                                                const IconConfiguration(
                                                    icon: Icons.done),
                                            backgroundColor: Colors.green);
                                        setState(() {
                                          roundNumber++;
                                          _atual = _quizes[roundNumber - 1];
                                          _controller.restart();
                                        });
                                        build(context);
                                      } else {}
                                    },
                                  ),
                                  AnimatedButton(
                                    height: 70,
                                    width: 300,
                                    color: const Color(0xFF647AEA),
                                    child: Text(
                                      _atual.opcoes![3],
                                      style: GoogleFonts.getFont(
                                        'IBM Plex Sans Thai',
                                        fontSize: 15,
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      _controller.pause();
                                      if (_atual.opcoes![3] ==
                                          _atual.respostaCerta!) {
                                        StatusAlert.show(context,
                                            duration:
                                                const Duration(seconds: 2),
                                            title: 'CERTAAAAA!',
                                            configuration:
                                                const IconConfiguration(
                                                    icon: Icons.done),
                                            backgroundColor: Colors.green);
                                        setState(() {
                                          roundNumber++;
                                          _atual = _quizes[roundNumber - 1];
                                          _controller.restart();
                                        });
                                        build(context);
                                      } else {}
                                    },
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
              )
            : Center(
                child: LoadingAnimationWidget.horizontalRotatingDots(
                size: 200,
                color: Colors.white,
              )),
      ),
    );
  }
}
