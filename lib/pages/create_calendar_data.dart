import 'package:agenda/models/calendar_data.dart';
import 'package:agenda/models/service.dart';
import 'package:agenda/utils/navigator.dart';
import 'package:agenda/pages/service_list.dart';
import 'package:agenda/repositories/calendar_data.dart';
import 'package:flutter/material.dart';

// Hoje é so isso
class CrateCalendarDataPage extends StatefulWidget {
  final String uid;

  const CrateCalendarDataPage({Key? key, required this.uid}) : super(key: key);
  @override
  _CrateCalendarDataPageState createState() => _CrateCalendarDataPageState();
}

class _CrateCalendarDataPageState extends State<CrateCalendarDataPage> {
  final TextEditingController clienteController = TextEditingController();

  final TextEditingController tempoController = TextEditingController();

  TimeOfDay startTime = TimeOfDay(hour: 10, minute: 0);

   String selectedService = 'Selecionar serviço';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar'),),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final DateTime start = timeOfDayToDateTime(startTime);
          final DateTime end = timeOfDayToDateTime(startTime)
              .add(Duration(minutes: int.parse(tempoController.text)));

          final c = CalendarDataModel(
              uid: widget.uid,
              name: clienteController.text,
              servico: selectedService,
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
                ServiceModel? r =
                    await push(context, ServiceListPage(uid: widget.uid));

                setState(() {
                  selectedService = r?.title ?? selectedService;
                });
              },
              title: Text(selectedService),
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
