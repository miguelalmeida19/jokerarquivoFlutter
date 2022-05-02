import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:math';
import 'package:random_words/random_words.dart';

import 'package:http/http.dart' as http;

Future<void> main() async {
  String phrase = await Questions.getPhrase();
  try {
    if (phrase != "") {
      Map<String, String> map = Questions.buildQuestion(phrase);
      if (map.isEmpty) {
        main();
      } else {
        print(map);
      }
    } else {
      main();
    }
  } catch (e) {
    main();
  }
}

class Questions {
  static Map<String, String> buildQuestion(String phrase) {
    Map<String, List<String>> matching = {
      'QUANDO?': [
        "em",
        "hoje",
        "já",
        "afinal",
        "logo",
        "agora",
        "amanhã",
        "amiúde",
        "antes",
        "ontem",
        "tarde",
        "breve",
        "cedo",
        "depois",
        "nunca",
        "sempre",
        "doravante",
        "primeiramente",
        "imediatamente",
        "antigamente",
        "provisoriamente",
        "sucessivamente",
        "constantemente",
        "na"
      ],
      'ONDE?': [
        "debaixo",
        "em cima",
        "ali",
        "aqui",
        "além",
        "abaixo",
        "aquém",
        "lá",
        "fora",
        "dentro",
        "acima",
        "diante",
        "atrás",
        "longe",
        "perto",
        "defronte",
        "algures",
        "cá",
        "nenhures",
        "adentro",
        "aquém",
        "externamente",
        "em"
      ],
      'O QUÊ?': ["a"],
      'DE QUÊ?': ["de", "da"],
      'DE QUEM?': ["de"],
      'QUEM?': ["um", "uma", "o", "os", "a", "as"],
      'DATA?': [
        "janeiro",
        "fevereiro",
        "março",
        "abril",
        "maio",
        "junho",
        "julho",
        "agosto",
        "setembro",
        "outubro",
        "novembro",
        "dezembro"
      ],
      'A ONDE?': ["à"],
      'PARA O QUÊ?': ["para"],
      'DO QUÊ?': ["do"],
      'E QUEM?': ["e"],
      'COMO QUEM?': ["como"],
      'POR ONDE?': ["pela", "pelo"],
      'OU O QUÊ?': ["ou"],
      'PELO QUÊ?': ["pela", "pelo", "por"],
      'EM QUÊ?': ["nas", "nos", "na", "no"],
      'E O QUÊ?': ["e"],
      "MAS O QUÊ?": ["mas"],
      "QUER O QUÊ?": ["quer"],
      "É O QUÊ?": ["é"]
    };

    List<String> diasSemana = [
      "segunda-feira",
      "terça-feira",
      "quarta-feira",
      "quinta-feira",
      "sexta-feira",
      "sábado",
      "domingo"
    ];

    List<String> meses = [
      "janeiro",
      "fevereiro",
      "março",
      "abril",
      "maio",
      "junho",
      "julho",
      "agosto",
      "setembro",
      "outubro",
      "novembro",
      "dezembro"
    ];

    phrase = phrase.replaceAll('...', "");

    List<String> list_words = phrase.split(' ');

    Map<String, String> results = {};
    int counter = 0;
    List<String> matchingValues = <String>[];

    for (var g in matching.values) {
      matchingValues.addAll(g);
    }

    for (String i in list_words) {
      if (matchingValues.contains(i)) {
        for (MapEntry<String, List<String>> entry in matching.entries) {
          for (var v in entry.value) {
            String question = "";
            if (v == i) {
              for (int j = 0; j < counter; j++) {
                question += " " + list_words[j];
              }
              question += " " + entry.key.toLowerCase();

              if (!results.keys.contains(question)) {
                String answer = "";
                for (int q = 0; q < list_words.length - counter; q++) {
                  answer += " " + list_words[q + counter];
                }
                results[question] = answer;
              }
            }
          }
        }
      }
      counter++;
    }

    //filtrar as perguntas

    Map<String, String> filteredResults = {};

    for (MapEntry<String, String> r in results.entries) {
      if (r.key.contains("quem?") &&
          r.value.split(" ")[1][0].toUpperCase() != r.value.split(" ")[1][0]) {
      } else if (r.key.contains("onde?") &&
          (r.value.split(" ")[2].contains('20') ||
              diasSemana.contains(r.value.split(" ")[2]) ||
              meses.contains(r.value.split(" ")[2]))) {
      } else if (r.key.contains("quando?") &&
          (!r.value.split(" ")[2].contains('20') ||
              !diasSemana.contains(r.value.split(" ")[2]) ||
              !meses.contains(r.value.split(" ")[2]))) {
      } else {
        filteredResults[r.key] = r.value;
      }
    }
    Map<String, String> questionAnswer = {};

    for (var s in filteredResults.entries) {
      questionAnswer[s.key] = s.value;
    }
    return questionAnswer;
  }

  static Future<String> getPhrase() async {
    String word = generateNoun().take(1).first.word;

    final response = await http.get(Uri.parse('https://arquivo.pt/textsearch?q=' +
        word +
        "&maxItems=1&prettyPrint=true&from=20190101000000&siteSearch=http://www.publico.pt"));

    String source = (Utf8Decoder().convert(response.bodyBytes));
    Map<String, dynamic> list = json.decode(source);
    List<dynamic> lista = list["response_items"];
    String res = lista[0]["title"];
    res = res.split(" | ")[0];
    return res;
  }
}
