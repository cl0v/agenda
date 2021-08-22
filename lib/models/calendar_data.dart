import 'dart:convert';

import 'package:agenda/models/service.dart';

class CalendarDataModel {
  // Não preciso enviar para servidor, é dmais po... (mas vai ajudar pakaraio a coletar dados)
  // A melhor forma de coletar dados é por servidor, ja que nao tenho contatos para dar feedback
  // Se eu deletar algum dado do servidor, o aplicativo vai ser mal avaliado, pois acabei cancelando as coisas
  // NÃO ENTRAR NO CONSOLE DO FIREBASE DEPOIS QUE LANÇAR O APP. (Dados sensiveis estão lá)
  String uid;
  String name;
  List<ServiceModel> servicos;
  DateTime start;
  DateTime end;

  CalendarDataModel({
    required this.uid,
    required this.name,
    required this.servicos,
    required this.start,
    required this.end,
  });

  String get text {
    List<String> i = servicos.map((e) => e.title).toList();
    String t = i.join('\n > ');
     
    return '$name \n > $t';
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'servicos': servicos.map((x) => x.toMap()).toList(),
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
    };
  }

  factory CalendarDataModel.fromMap(Map<String, dynamic> map) {
    return CalendarDataModel(
      uid: map['uid'],
      name: map['name'],
      servicos: List<ServiceModel>.from(
          map['servicos']?.map((x) => ServiceModel.fromMap(x))),
      start: DateTime.fromMillisecondsSinceEpoch(map['start']),
      end: DateTime.fromMillisecondsSinceEpoch(map['end']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarDataModel.fromJson(String source) =>
      CalendarDataModel.fromMap(json.decode(source));
}
