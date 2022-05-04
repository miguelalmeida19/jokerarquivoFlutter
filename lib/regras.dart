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
import 'package:vertical_card_pager/vertical_card_pager.dart';

class Regras extends StatefulWidget {
  const Regras({Key? key}) : super(key: key);

  @override
  State<Regras> createState() => _RegrasState();
}

class _RegrasState extends State<Regras> {

  final List<String> titles = ["Cada pergunta tem 40 segundos de tempo", "9 Jokers inicialmente", "Se errar perde 3 Jokers", "1-4 perguntas normais", "Se não houver mais jokers, retira prémios.", "No fim ganha o dinheiro que se encontra no prémio.", ];

  final List<Widget> images = [
    Container(
      color: const Color(0xFFFF9AA2),
    ),
    Container(
      color: const Color(0xFFFFB7B2),
    ),
    Container(
      color: const Color(0xFFFFDAC1),
    ),
    Container(
      color: const Color(0xFFE2F0CB),
    ),
    Container(
      color: const Color(0xFFB5EAD7),
    ),
    Container(
      color: const Color(0xFFC7CEEA),
    ),
  ];

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
          color: const Color(0xFF5E78BD),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              AnimatedButton(
                height: 100,
                color: const Color(0xFF8699FF),
                child: Text(
                  'VOLTAR AO MENU',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'IBM Plex Sans Thai',
                    fontSize: 30,
                    textStyle: TextStyle(color: Colors.white),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const Home()));
                },
              ),
              Expanded(
                child: Container(
                  child: VerticalCardPager(
                      titles: titles,  // required
                      images: images,  // required
                      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15), // optional
                      onPageChanged: (page) { // optional
                      },
                      onSelectedItem: (index) { // optional
                      },
                      initialPage: 0, // optional
                      align : ALIGN.CENTER // optional
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
