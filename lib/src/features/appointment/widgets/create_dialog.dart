import 'package:agenda/authenticator_provider.dart';
import 'package:agenda/src/features/appointment/models.dart';
import 'package:agenda/src/features/appointment/repositories.dart';
import 'package:agenda/utils/navigator.dart';
import 'package:flutter/material.dart';

//TODO: Implementar sistema automatico se seleção de data;

class CreateAppointmentDialog extends StatefulWidget {
  const CreateAppointmentDialog({Key? key}) : super(key: key);

  @override
  _CreateAppointmentDialogState createState() =>
      _CreateAppointmentDialogState();
}

class _CreateAppointmentDialogState extends State<CreateAppointmentDialog> {
  final nameController = TextEditingController();
  TimeOfDay time = TimeOfDay.now();

  DateTime day = DateTime.now();

  Appointment get _appointment {
    final _day = DateTime(day.year, day.month, day.day, time.hour, time.minute);

    return Appointment(
        Horario.fromDateTime(_day), nameController.text, ['nenhum']);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //TODO: Cadastrar servicos
                // TODO: Seletor por popup https://pub.dev/packages/smart_select
                // ListTile(
                //   title: Text('Serviços selecionados:'),
                //   onTap: () => push(context, ServiceListPage()),
                // ), //

                ListTile(
                  onTap: () async {
                    //Usar o picker bonitin
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

                ListTile(
                  title: Text('Formar selecionados 3 serviços'),
                  subtitle: Text('Toque para ver os serviços selecionados.'),
                ),

                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'Nome', hintText: 'Nome do cliente'),
                ),
                Divider(),

                Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        child: Text("CANCELAR"),
                        onPressed: () async {
                          pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text("AGENDAR"),
                        onPressed: () async {
                          final userid = Authenticator.of(context).id;
                          AppointmentRepository.create(userid, _appointment);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
