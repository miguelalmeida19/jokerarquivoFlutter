import 'dart:math';

import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jokerarquivo/main.dart';
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
  int numberOfJokers = 9;
  int maxJokers = 9;
  List<int> premios = [0, 250, 500, 1000, 2500, 5000, 10000, 25000, 75000];
  int dinheiroAtual = 0;
  int dinheiroAtualIndex = 0;
  bool jokerSelected = false;
  int jokersSelected = 0;
  List<int> selected = [];

  List<Color> color = [const Color(0xFF647AEA), const Color(0xFF647AEA), const Color(0xFF647AEA), const Color(0xFF647AEA)];

  List<bool> options = [true, true, true, true];

  Neumorphic joker = Neumorphic(
    style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        color: Colors.transparent),
    child: Image.asset(
      'assets/img/logo.png',
      scale: 4,
    ),
  );
  Neumorphic jokerPodre = Neumorphic(
    style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        color: Colors.transparent),
    child: Image.asset(
      'assets/img/logoPodre.png',
      scale: 4,
    ),
  );

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
          acabouTempo();
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

  void acertou() {
    jokersSelected = 0;
    jokerSelected = false;
    options = [true, true, true, true];
    color[0] = const Color(0xFF647AEA);
    color[1] = const Color(0xFF647AEA);
    color[2] = const Color(0xFF647AEA);
    color[3] = const Color(0xFF647AEA);
    if (roundNumber != maxRound) {
      StatusAlert.show(context,
          duration: const Duration(seconds: 2),
          title: 'CERTAAAAA!',
          configuration: const IconConfiguration(icon: Icons.done),
          backgroundColor: Colors.green);
      setState(() {
        if (dinheiroAtual != premios.last) {
          dinheiroAtualIndex++;
        }
        roundNumber++;
        _atual = _quizes[roundNumber - 1];
        _controller.restart();
      });
      build(context);
    } else {
      setState(() {
        if (dinheiroAtual != premios.last) {
          dinheiroAtualIndex++;
        }
        dinheiroAtual = premios[dinheiroAtualIndex];
      });
      StatusAlert.show(context,
          duration: const Duration(seconds: 5),
          title: 'GANHOUUUUUUU!',
          subtitle: "PRÉMIO: " + dinheiroAtual.toString() + " EUROS !!!",
          configuration:
              const IconConfiguration(icon: Icons.emoji_events_rounded),
          backgroundColor: Colors.green);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  void errou() {
    jokersSelected = 0;
    jokerSelected = false;
    options = [true, true, true, true];
    color[0] = const Color(0xFF647AEA);
    color[1] = const Color(0xFF647AEA);
    color[2] = const Color(0xFF647AEA);
    color[3] = const Color(0xFF647AEA);
    if (roundNumber != maxRound) {
      StatusAlert.show(context,
          duration: const Duration(seconds: 2),
          title: 'ERRADA!',
          configuration: const IconConfiguration(icon: Icons.close_rounded),
          backgroundColor: Colors.red);
      if (numberOfJokers >= 3) {
        setState(() {
          roundNumber++;
          _atual = _quizes[roundNumber - 1];
          _controller.restart();
          numberOfJokers -= 3;
        });
        build(context);
      } else {
        int numeroRetirar = 3;
        setState(() {
          roundNumber++;
          _atual = _quizes[roundNumber - 1];
          _controller.restart();
          while (numberOfJokers > 0) {
            numberOfJokers--;
            numeroRetirar--;
          }
          while (numeroRetirar > 0 && dinheiroAtualIndex > 0) {
            dinheiroAtualIndex--;
          }
        });
        build(context);
      }
    } else {
      setState(() {
        if (dinheiroAtual != premios.last) {
          dinheiroAtualIndex++;
        }
        dinheiroAtual = premios[dinheiroAtualIndex];
      });
      StatusAlert.show(context,
          duration: const Duration(seconds: 5),
          title: 'GANHOUUUUUUU!',
          subtitle: "PRÉMIO: " + dinheiroAtual.toString() + " EUROS !!!",
          configuration:
              const IconConfiguration(icon: Icons.emoji_events_rounded),
          backgroundColor: Colors.green);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  void acabouTempo() {
    jokersSelected = 0;
    jokerSelected = false;
    options = [true, true, true, true];
    color[0] = const Color(0xFF647AEA);
    color[1] = const Color(0xFF647AEA);
    color[2] = const Color(0xFF647AEA);
    color[3] = const Color(0xFF647AEA);
    if (numberOfJokers > 0) {
      StatusAlert.show(context,
          duration: const Duration(seconds: 2),
          title: 'ACABOU O TEMPO!',
          configuration: const IconConfiguration(icon: Icons.close_rounded),
          backgroundColor: Colors.red);
      if (numberOfJokers >= 3) {
        setState(() {
          roundNumber++;
          _atual = _quizes[roundNumber - 1];
          _controller.restart();
          numberOfJokers -= 3;
        });
        build(context);
      } else {
        int numeroRetirar = 3;
        setState(() {
          roundNumber++;
          _atual = _quizes[roundNumber - 1];
          _controller.restart();
          while (numberOfJokers > 0) {
            numberOfJokers--;
            numeroRetirar--;
          }
          while (numeroRetirar > 0) {
            dinheiroAtualIndex--;
          }
        });
        build(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    dinheiroAtual = premios[dinheiroAtualIndex];

    Column jokers = Column(
      verticalDirection: VerticalDirection.up,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
    Column premiosList = Column(
      verticalDirection: VerticalDirection.up,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );

    for (int i = 0; i < numberOfJokers; i++) {
      jokers.children.add(joker);
    }

    if (maxJokers != numberOfJokers) {
      for (int i = 0; i < maxJokers - numberOfJokers; i++) {
        jokers.children.add(jokerPodre);
      }
    }

    for (int j = 0; j < premios.length; j++) {
      if (premios[j] == dinheiroAtual) {
        Neumorphic premio = Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
              color: Colors.transparent),
          child: SizedBox(
            width: 100,
            child: Neumorphic(
              style: NeumorphicStyle(
                color: const Color(0xFFFFA800),
                shape: NeumorphicShape.flat,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
              ),
              child: Text(
                premios[j].toString() + "€",
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
            ),
          ),
        );
        premiosList.children.add(const SizedBox(
          height: 5,
        ));
        premiosList.children.add(premio);
      } else {
        Neumorphic premio = Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
              color: Colors.transparent),
          child: SizedBox(
            width: 100,
            child: Neumorphic(
              style: NeumorphicStyle(
                color: const Color(0xFF5E5E5E),
                shape: NeumorphicShape.flat,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
              ),
              child: Text(
                premios[j].toString() + "€",
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
            ),
          ),
        );
        premiosList.children.add(const SizedBox(
          height: 5,
        ));
        premiosList.children.add(premio);
      }
    }

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    jokers,
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
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
                            height: 400,
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
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
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
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
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
                                          color: color[0],
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
                                            if (options[0]) {
                                              _controller.pause();
                                              if (!jokerSelected) {
                                                if (_atual.opcoes![0] ==
                                                    _atual.respostaCerta!) {
                                                  acertou();
                                                } else {
                                                  errou();
                                                }
                                              } else {
                                                if (numberOfJokers > 0) {
                                                  if (jokersSelected < 2) {
                                                    if (!selected.contains(0)) {
                                                      setState(() {
                                                        selected.add(0);
                                                        jokersSelected++;
                                                        color[0] =
                                                            Color(0xFFFFA800);
                                                      });
                                                    } else {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'ESSA OPÇÃO JÁ FOI SELECIONADA!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .close_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                    }
                                                    if (jokersSelected == 1) {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'ESCOLHE OUTRA OPÇÃO!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .arrow_drop_down_circle_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                    }
                                                    if (jokersSelected == 2) {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'UMA DAS OPÇÕES IRÁ FICAR INDISPONÍVEL!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .arrow_drop_down_circle_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                      if (_atual.opcoes![0] ==
                                                          _atual
                                                              .respostaCerta!) {
                                                        setState(() {
                                                          selected.remove(0);
                                                          options[selected[0]] =
                                                              false;
                                                          jokerSelected = false;
                                                          jokersSelected = 0;
                                                          color[0] = const Color(0xFF647AEA);
                                                        });
                                                      } else {
                                                        int max = 1;
                                                        int randomNumber =
                                                            Random()
                                                                .nextInt(max);
                                                        setState(() {
                                                          selected.remove(
                                                              selected[
                                                                  randomNumber]);
                                                          options[selected[
                                                                  randomNumber]] =
                                                              false;
                                                          color[selected[
                                                          randomNumber]] = const Color(0xFF647AEA);

                                                          jokerSelected = false;
                                                        });
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          },
                                        ),
                                        AnimatedButton(
                                          height: 70,
                                          width: 300,
                                          color: color[1],
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
                                            if (options[1]) {
                                              _controller.pause();
                                              if (!jokerSelected) {
                                                if (_atual.opcoes![1] ==
                                                    _atual.respostaCerta!) {
                                                  acertou();
                                                } else {
                                                  errou();
                                                }
                                              } else {
                                                if (numberOfJokers > 0) {
                                                  if (jokersSelected < 2) {
                                                    if (!selected.contains(1)) {
                                                      setState(() {
                                                        selected.add(1);
                                                        jokersSelected++;
                                                        color[1] =
                                                            Color(0xFFFFA800);
                                                      });
                                                    } else {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'ESSA OPÇÃO JÁ FOI SELECIONADA!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .close_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                    }
                                                    if (jokersSelected == 1) {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'ESCOLHE OUTRA OPÇÃO!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .arrow_drop_down_circle_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                    }
                                                    if (jokersSelected == 2) {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'UMA DAS OPÇÕES IRÁ FICAR INDISPONÍVEL!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .arrow_drop_down_circle_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                      if (_atual.opcoes![1] ==
                                                          _atual
                                                              .respostaCerta!) {
                                                        setState(() {
                                                          selected.remove(1);
                                                          options[selected[0]] =
                                                              false;
                                                          jokerSelected = false;
                                                          jokersSelected = 0;
                                                          color[1] = const Color(0xFF647AEA);
                                                        });
                                                      } else {
                                                        int max = 1;
                                                        int randomNumber =
                                                            Random()
                                                                .nextInt(max);
                                                        setState(() {
                                                          selected.remove(
                                                              selected[
                                                                  randomNumber]);
                                                          options[selected[
                                                                  randomNumber]] =
                                                              false;
                                                          jokerSelected = false;
                                                          color[selected[
                                                          randomNumber]] = const Color(0xFF647AEA);
                                                        });
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          },
                                        ),
                                        AnimatedButton(
                                          height: 70,
                                          width: 300,
                                          color: color[2],
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
                                            if (options[2]) {
                                              _controller.pause();
                                              if (!jokerSelected) {
                                                if (_atual.opcoes![0] ==
                                                    _atual.respostaCerta!) {
                                                  acertou();
                                                } else {
                                                  errou();
                                                }
                                              } else {
                                                if (numberOfJokers > 0) {
                                                  if (jokersSelected < 2) {
                                                    if (!selected.contains(2)) {
                                                      setState(() {
                                                        selected.add(2);
                                                        jokersSelected++;
                                                        color[2] =
                                                            Color(0xFFFFA800);
                                                      });
                                                    } else {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'ESSA OPÇÃO JÁ FOI SELECIONADA!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .close_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                    }
                                                    if (jokersSelected == 1) {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'ESCOLHE OUTRA OPÇÃO!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .arrow_drop_down_circle_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                    }
                                                    if (jokersSelected == 2) {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'UMA DAS OPÇÕES IRÁ FICAR INDISPONÍVEL!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .arrow_drop_down_circle_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                      if (_atual.opcoes![2] ==
                                                          _atual
                                                              .respostaCerta!) {
                                                        setState(() {
                                                          selected.remove(2);
                                                          options[selected[0]] =
                                                              false;
                                                          jokerSelected = false;
                                                          jokersSelected = 0;
                                                          color[2] = const Color(0xFF647AEA);
                                                        });
                                                      } else {
                                                        int max = 1;
                                                        int randomNumber =
                                                            Random()
                                                                .nextInt(max);
                                                        setState(() {
                                                          selected.remove(
                                                              selected[
                                                                  randomNumber]);
                                                          options[selected[
                                                                  randomNumber]] =
                                                              false;
                                                          jokerSelected = false;
                                                          color[selected[
                                                          randomNumber]] = const Color(0xFF647AEA);
                                                        });
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          },
                                        ),
                                        AnimatedButton(
                                          height: 70,
                                          width: 300,
                                          color: color[3],
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
                                            if (options[3]) {
                                              _controller.pause();
                                              if (!jokerSelected) {
                                                if (_atual.opcoes![0] ==
                                                    _atual.respostaCerta!) {
                                                  acertou();
                                                } else {
                                                  errou();
                                                }
                                              } else {
                                                if (numberOfJokers > 0) {
                                                  if (jokersSelected < 2) {
                                                    if (!selected.contains(3)) {
                                                      setState(() {
                                                        selected.add(3);
                                                        jokersSelected++;
                                                        color[3] =
                                                            Color(0xFFFFA800);
                                                      });
                                                    } else {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'ESSA OPÇÃO JÁ FOI SELECIONADA!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .close_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                    }
                                                    if (jokersSelected == 1) {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'ESCOLHE OUTRA OPÇÃO!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .arrow_drop_down_circle_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                    }
                                                    if (jokersSelected == 2) {
                                                      StatusAlert.show(context,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          title:
                                                              'UMA DAS OPÇÕES IRÁ FICAR INDISPONÍVEL!',
                                                          configuration:
                                                              const IconConfiguration(
                                                                  icon: Icons
                                                                      .arrow_drop_down_circle_rounded),
                                                          backgroundColor:
                                                              Colors.yellow);
                                                      if (_atual.opcoes![3] ==
                                                          _atual
                                                              .respostaCerta!) {
                                                        setState(() {
                                                          selected.remove(3);
                                                          options[selected[0]] =
                                                              false;
                                                          jokerSelected = false;
                                                          jokersSelected = 0;
                                                          color[3] = const Color(0xFF647AEA);
                                                        });
                                                      } else {
                                                        int max = 1;
                                                        int randomNumber =
                                                            Random()
                                                                .nextInt(max);
                                                        setState(() {
                                                          selected.remove(
                                                              selected[
                                                                  randomNumber]);
                                                          options[selected[
                                                                  randomNumber]] =
                                                              false;
                                                          jokerSelected = false;
                                                          color[selected[
                                                          randomNumber]] = const Color(0xFF647AEA);
                                                        });
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  AnimatedButton(
                                      height: 70,
                                      width: 150,
                                      color: const Color(0xFFFCE300),
                                      child: joker,
                                      onPressed: () {
                                        if (jokerSelected == false &&
                                            numberOfJokers > 0) {
                                          _controller.pause();
                                          StatusAlert.show(context,
                                              duration:
                                                  const Duration(seconds: 1),
                                              title: 'SELECIONA DUAS OPÇÕES!',
                                              configuration:
                                                  const IconConfiguration(
                                                      icon: Icons
                                                          .arrow_drop_down_circle_rounded),
                                              backgroundColor: Colors.yellow);
                                          setState(() {
                                            numberOfJokers--;
                                            jokerSelected = true;
                                          });
                                        } else {
                                          StatusAlert.show(context,
                                              duration:
                                                  const Duration(seconds: 1),
                                              title:
                                                  'JÁ NÃO TENS JOKERS, OU JÁ SELECIONASTE ISTO :))',
                                              configuration:
                                                  const IconConfiguration(
                                                      icon:
                                                          Icons.close_rounded),
                                              backgroundColor: Colors.yellow);
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    premiosList
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
