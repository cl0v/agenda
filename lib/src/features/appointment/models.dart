
import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final DateTime day;
  final String cliente;
  final List<String>
      listaDosServicosEscolhidos; //A pessoa não precisa saber detalhe do agendamento (Valor de cada item e tempo gasto)

  // String _valor;


  Appointment(
    this.day,
    this.cliente,
    // this._valor,
    this.listaDosServicosEscolhidos,
  );

  String get horario => '${day.hour} : ${day.minute}';


  Map<String, dynamic> toMap() {
    return {
      'day': Timestamp.fromDate(day) ,
      'cliente': cliente,
      'listaDosServicosEscolhidos': listaDosServicosEscolhidos,
    };
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
