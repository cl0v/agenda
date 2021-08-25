import 'package:flutter/material.dart';

class CreateAppointmentPage extends StatelessWidget {
  const CreateAppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Column(
        children: [
          //TODO: Selecionar os serviços primeiro
          ListTile(title: Text('Serviços selecionados:'), ),
          ListTile(
            onTap: () async {
              showTimePicker(context: context, initialTime: TimeOfDay.now());
            },
            title: Text('Será agendados para as 18:00 horas'),
            subtitle: Text('Toque para escolher outro horário.'),
          ),
          ListTile(
            onTap: () async {
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 30)));
            },
            title: Text('Será agendado para o dia 19/03'),
            subtitle: Text('Toque para escolher outro dia.'),
          ),
        ],
      )),
    );
  }
}
