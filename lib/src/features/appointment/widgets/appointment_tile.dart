

import 'package:flutter/material.dart';

import '../models.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment agendamento;
  const AppointmentTile({
    Key? key,
    required this.agendamento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        // title: Center(child: Text('R\$${agendamento.valor}')),
        title: Center(child: Text(agendamento.cliente)),
        leading: Text(agendamento.horario),
        trailing: Icon(Icons.info),
        // children: [
        //   ...agendamento.listaDosServicosEscolhidos.map((e) => Text(e)).toList()
        // ],
      ),
    );
  }
}