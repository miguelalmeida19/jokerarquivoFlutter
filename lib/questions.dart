void main() {
  Questions.buildQuestion(
      'Dronestagram: voaram sobre o mundo, em 2018, para terem as melhores fotografias aéreas');
}

class Questions {
  static buildQuestion(String phrase) {
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
      'O QUÊ?': ["é", "a"],
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
      'EM O QUÊ?': ["e"],
      "MAS O QUÊ?": ["mas"],
      "QUER O QUÊ?": ["quer"],
    };

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
      } else {
        filteredResults[r.key] = r.value;
      }
    }
    for (var s in filteredResults.entries) {
      print(s.key + ": " + s.value);
    }
  }
}
