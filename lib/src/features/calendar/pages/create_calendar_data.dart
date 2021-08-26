import 'package:agenda/src/features/calendar/models/calendar_data.dart';
import 'package:agenda/src/features/service/models/service.dart';
import 'package:agenda/utils/navigator.dart';
import 'package:agenda/src/features/service/widgets/list_tile.dart';
import 'package:agenda/src/features/calendar/repositories/calendar_data.dart';
import 'package:flutter/material.dart';

class CrateCalendarDataPage extends StatefulWidget {

  @override
  _CrateCalendarDataPageState createState() => _CrateCalendarDataPageState();
}

class _CrateCalendarDataPageState extends State<CrateCalendarDataPage> {
  final TextEditingController clienteController = TextEditingController();

  final TextEditingController tempoController = TextEditingController();

  TimeOfDay startTime = TimeOfDay(hour: 10, minute: 0);

  List<ServiceModel> selectedService = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final DateTime start = timeOfDayToDateTime(startTime);
          final DateTime end = timeOfDayToDateTime(startTime)
              .add(Duration(minutes: int.parse(tempoController.text)));

          final c = CalendarDataModel(
              uid: 'widget.uid',
              name: clienteController.text,
              servicos: selectedService,
              start: start,
              end: end);

          CalendarDataRepository().create(c);
          pop(context);
        },
        label: Text('Adicionar'),
        icon: Icon(Icons.add),
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: clienteController,
              decoration: InputDecoration(
                  hintText: 'Nome da pessoa', labelText: 'Nome do cliente'),
            ),
            ListTile(
              onTap: () async {
                // List<ServiceModel> r = await push(
                        // context,
                        // ServiceListPage(
                        //   selectedServices: selectedService,
                        // )) ??
                    // [];

                // setState(() {
                //   selectedService = r ?? selectedService;
                // });
              },
              title: Text('Toque para selecionar servicos'),
            ),
            TextFormField(
              controller: tempoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: '50', labelText: 'Quanto tempo demora o serviço'),
            ),

            ListTile(
              onTap: () async {
                final timePicked = await showTimePicker(
                    context: context, initialTime: startTime);
                setState(() {
                  startTime = timePicked ?? startTime;
                });
              },
              title: Text(startTime.format(context)),
              subtitle: Text('O horario selecionado foi'),
            )

            // Dois seletores
          ],
        ),
      ),
    );
  }
}

DateTime timeOfDayToDateTime(TimeOfDay t) {
  final now = new DateTime.now();
  return new DateTime(now.year, now.month, now.day, t.hour, t.minute);
}
