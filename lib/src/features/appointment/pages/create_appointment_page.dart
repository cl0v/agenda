import 'package:agenda/src/features/appointment/models.dart';
import 'package:agenda/src/features/appointment/widgets/create_button.dart';
import 'package:agenda/src/features/service/widgets/list_tile.dart';
import 'package:agenda/utils/navigator.dart';
import 'package:flutter/material.dart';

class CreateAppointmentPage extends StatefulWidget {
  const CreateAppointmentPage({Key? key}) : super(key: key);

  @override
  _CreateAppointmentPageState createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  final nameController = TextEditingController();
  TimeOfDay time = TimeOfDay.now();

  DateTime day = DateTime.now();

  Appointment _appointment() {
    final _day = DateTime(day.year, day.month, day.day, time.hour, time.minute);

    return Appointment(
        Horario.fromDateTime(_day), nameController.text, ['nenhum']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agendamento'),),
      floatingActionButton: CreateAppointmentButton(
        appointment: _appointment,
      ),
      body: Form(
          child: Column(
        children: [
          //TODO: Cadastrar servicos
          // ListTile(
          //   title: Text('Serviços selecionados:'),
          //   onTap: () => push(context, ServiceListPage()),
          // ), //

          ListTile(
            onTap: () async {
              time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now()) ??
                  time;
            },
            title: Text('Será agendados para as 18:00 horas'),
            subtitle: Text('Toque para escolher outro horário.'),
          ),
          ListTile(
            onTap: () async {
              day = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 30))) ??
                  day;
            },
            title: Text('Será agendado para o dia 19/03'),
            subtitle: Text('Toque para escolher outro dia.'),
          ),

          TextFormField(
            controller: nameController,
            decoration:
                InputDecoration(labelText: 'Nome', hintText: 'Nome do cliente'),
          ),
        ],
      )),
    );
  }
}
