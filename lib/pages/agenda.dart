import 'package:agenda/authenticator.dart';
import 'package:agenda/src/features/appointment/repositories.dart';
import 'package:agenda/src/features/appointment/widgets/appointment_tile.dart';
import 'package:flutter/material.dart';


class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() =>
      _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<List>(
          stream: AppointmentRepository.todayAppointments(
            Authenticator.of(context).id,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView(
                children: snapshot.data
                        ?.map((e) => AppointmentTile(agendamento: e))
                        .toList() ??
                    [],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
