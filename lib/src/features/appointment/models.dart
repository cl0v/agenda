import 'dart:convert';

import 'package:flutter/material.dart';

class Appointment {
  //TODO: Criar nome estatico para se referir la no firestore

  final Horario date; // Esse carinha não vai rolar, pois
  final String clientName;
  final List<String> serviceList;
  //A pessoa não precisa saber detalhe do agendamento (Valor de cada item e tempo gasto)

  // String _valor;

  Appointment(
    // this._valor,
    this.date,
    this.clientName,
    this.serviceList,
  );


  Map<String, dynamic> toMap() {
    return {
      'date': date.toMap(),
      'clientName': clientName,
      'serviceList': serviceList,
    };
  }

  String  horario(context) => TimeOfDay(hour: date.hour, minute: date.minute).format(context);

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      Horario.fromMap(map['date']),
      map['clientName'],
      List<String>.from(map['serviceList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source));
}

class Horario {
  int year;
  int month;
  int day;
  int hour;
  int minute;

  Horario({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
  });

  factory Horario.fromDateTime(DateTime date) => Horario(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: date.hour,
        minute: date.minute,
      );

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'month': month,
      'day': day,
      'hour': hour,
      'minute': minute,
    };
  }

  factory Horario.fromMap(Map<String, dynamic> map) {
    return Horario(
      year: map['year'],
      month: map['month'],
      day: map['day'],
      hour: map['hour'],
      minute: map['minute'],
    );
  }
}

List<Appointment> l = [
  // Appointment('11:00', 'Renata', '30,00', [
  //   'Corte',
  //   'Unhas',
  // ]),
  // Appointment('12:00', 'Paula', '25,00', [
  //   'Corte',
  //   'Unhas',
  // ]),
  // Appointment('13:30', 'Fabiola', '40,00', [
  //   'Corte',
  //   'Unhas',
  // ]),
  // Appointment('14:00', 'Jessica', '50,00', [
  //   'Corte',
  //   'Unhas',
  // ]),
];

// class Dados especificos de agendamento... Exp:
// Data de criação

// class AppointmentLog extends Appointment {
//   //Esse aq tem muita cara de Agendamento(RepositoryModel)
//   Timestamp createdAt;
//   // Editado, etc.... O que for tendo necessidade vai adicionano aq
//   // String userId; // Ainda nao tenho userId

//   AppointmentLog(String horario, String cliente, String valor,
//       List<String> listaDosServicosEscolhidos)
//       : createdAt = Timestamp.now(),
//         super(horario, cliente, valor, listaDosServicosEscolhidos);
// }
