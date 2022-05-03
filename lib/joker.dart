import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jokerarquivo/questions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Joker extends StatefulWidget {
  const Joker({Key? key}) : super(key: key);

  @override
  State<Joker> createState() => _JokerState();
}

class _JokerState extends State<Joker> {
  late Quiz _quiz;
  bool isLoading = false;

  Future<Quiz> buildQuiz() async {
    return await getQuiz();
  }

  @override
  void initState() {
    super.initState();

    buildQuiz().then((results) {
      setState(() {
        _quiz = results;
        isLoading = true;
      });
    });
  }

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
                      height: 300,
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
                                      child: SelectableText(
                                    _quiz.pergunta!,
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
                              width: 600,
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                alignment: WrapAlignment.center,
                                children: [
                                  AnimatedButton(
                                    height: 70,
                                    width: 250,
                                    color: const Color(0xFF647AEA),
                                    child: Text(
                                      _quiz.opcoes![0],
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
                                      if (_quiz.opcoes![0]==_quiz.respostaCerta!){
                                        showDialog(
                                            context: context,builder: (_) => AssetGiffyDialog(
                                          image: Image.network('https://media2.giphy.com/media/t1i8KZ7momVs4/giphy.gif?cid=790b76112832f130a1a63a4f74636c142d0b8c6c8d2ba9d2&rid=giphy.gif&ct=g'),
                                          title: Text('Resposta Correta!',
                                            style: TextStyle(
                                                fontSize: 22.0, fontWeight: FontWeight.w600),
                                          ),
                                          description: Text('Continua! Estás a sair-te bem!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(),
                                          ),
                                          entryAnimation: EntryAnimation.RIGHT,
                                          onOkButtonPressed: () {},
                                        ) );
                                      }else {
                                        showDialog(
                                            context: context,builder: (_) => AssetGiffyDialog(
                                          image: Image.network("https://media4.giphy.com/media/m8eIbBdkJK7Go/giphy.gif?cid=ecf05e47psphxdrgi5r12w9gol4cl1gyck9ws87fcanw0bgy&rid=giphy.gif&ct=g"),
                                          title: Text('Resposta Errada!',
                                            style: TextStyle(
                                                fontSize: 22.0, fontWeight: FontWeight.w600),
                                          ),
                                          description: Text('Mais sorte para a próxima talvez...',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(),
                                          ),
                                          entryAnimation: EntryAnimation.RIGHT,
                                          onOkButtonPressed: () {},
                                        ) );
                                        sleep(Duration(seconds: 2));
                                        build(context);
                                      }
                                    },
                                  ),
                                  AnimatedButton(
                                    height: 70,
                                    width: 250,
                                    color: const Color(0xFF647AEA),
                                    child: Text(
                                      _quiz.opcoes![1],
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
                                      if (_quiz.opcoes![1]==_quiz.respostaCerta!){
                                        showDialog(
                                            context: context,builder: (_) => AssetGiffyDialog(
                                          image: Image.network('https://media2.giphy.com/media/t1i8KZ7momVs4/giphy.gif?cid=790b76112832f130a1a63a4f74636c142d0b8c6c8d2ba9d2&rid=giphy.gif&ct=g'),
                                          title: Text('Resposta Correta!',
                                            style: TextStyle(
                                                fontSize: 22.0, fontWeight: FontWeight.w600),
                                          ),
                                          description: Text('Continua! Estás a sair-te bem!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(),
                                          ),
                                          entryAnimation: EntryAnimation.RIGHT,
                                          onOkButtonPressed: () {},
                                        ) );
                                      }else {
                                        showDialog(
                                            context: context,builder: (_) => AssetGiffyDialog(
                                          image: Image.network("https://media4.giphy.com/media/m8eIbBdkJK7Go/giphy.gif?cid=ecf05e47psphxdrgi5r12w9gol4cl1gyck9ws87fcanw0bgy&rid=giphy.gif&ct=g"),
                                          title: Text('Resposta Errada!',
                                            style: TextStyle(
                                                fontSize: 22.0, fontWeight: FontWeight.w600),
                                          ),
                                          description: Text('Mais sorte para a próxima talvez...',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(),
                                          ),
                                          entryAnimation: EntryAnimation.RIGHT,
                                          onOkButtonPressed: () {},
                                        ) );
                                        sleep(Duration(seconds: 2));
                                        build(context);
                                      }
                                    },
                                  ),
                                  AnimatedButton(
                                    height: 70,
                                    width: 250,
                                    color: const Color(0xFF647AEA),
                                    child: Text(
                                      _quiz.opcoes![2],
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
                                      if (_quiz.opcoes![2]==_quiz.respostaCerta!){
                                        showDialog(
                                            context: context,builder: (_) => AssetGiffyDialog(
                                          image: Image.network('https://media2.giphy.com/media/t1i8KZ7momVs4/giphy.gif?cid=790b76112832f130a1a63a4f74636c142d0b8c6c8d2ba9d2&rid=giphy.gif&ct=g'),
                                          title: Text('Resposta Correta!',
                                            style: TextStyle(
                                                fontSize: 22.0, fontWeight: FontWeight.w600),
                                          ),
                                          description: Text('Continua! Estás a sair-te bem!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(),
                                          ),
                                          entryAnimation: EntryAnimation.RIGHT,
                                          onOkButtonPressed: () {},
                                        ) );
                                      }else {
                                        showDialog(
                                            context: context,builder: (_) => AssetGiffyDialog(
                                          image: Image.network("https://media4.giphy.com/media/m8eIbBdkJK7Go/giphy.gif?cid=ecf05e47psphxdrgi5r12w9gol4cl1gyck9ws87fcanw0bgy&rid=giphy.gif&ct=g"),
                                          title: Text('Resposta Errada!',
                                            style: TextStyle(
                                                fontSize: 22.0, fontWeight: FontWeight.w600),
                                          ),
                                          description: Text('Mais sorte para a próxima talvez...',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(),
                                          ),
                                          entryAnimation: EntryAnimation.RIGHT,
                                          onOkButtonPressed: () {},
                                        ) );
                                        sleep(Duration(seconds: 2));
                                        build(context);
                                      }
                                    },
                                  ),
                                  AnimatedButton(
                                    height: 70,
                                    width: 250,
                                    color: const Color(0xFF647AEA),
                                    child: Text(
                                      _quiz.opcoes![3],
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
                                      if (_quiz.opcoes![3]==_quiz.respostaCerta!){
                                        showDialog(
                                            context: context,builder: (_) => AssetGiffyDialog(
                                          image: Image.network('https://media2.giphy.com/media/t1i8KZ7momVs4/giphy.gif?cid=790b76112832f130a1a63a4f74636c142d0b8c6c8d2ba9d2&rid=giphy.gif&ct=g'),
                                          title: Text('Resposta Correta!',
                                            style: TextStyle(
                                                fontSize: 22.0, fontWeight: FontWeight.w600),
                                          ),
                                          description: Text('Continua! Estás a sair-te bem!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(),
                                          ),
                                          entryAnimation: EntryAnimation.RIGHT,
                                          onOkButtonPressed: () {},
                                        ) );
                                      }else {
                                        showDialog(
                                            context: context,builder: (_) => AssetGiffyDialog(
                                          image: Image.network("https://media4.giphy.com/media/m8eIbBdkJK7Go/giphy.gif?cid=ecf05e47psphxdrgi5r12w9gol4cl1gyck9ws87fcanw0bgy&rid=giphy.gif&ct=g"),
                                          title: Text('Resposta Errada!',
                                            style: TextStyle(
                                                fontSize: 22.0, fontWeight: FontWeight.w600),
                                          ),
                                          description: Text('Mais sorte para a próxima talvez...',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(),
                                          ),
                                          entryAnimation: EntryAnimation.RIGHT,
                                          onOkButtonPressed: () {},
                                        ) );
                                        sleep(Duration(seconds: 2));
                                        build(context);
                                      }
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
                size: 200, color: Colors.white,
              )),
      ),
    );
  }
}
