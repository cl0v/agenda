import 'package:agenda/authenticator.dart';
import 'package:agenda/src/features/appointment/repositories.dart';
import 'package:agenda/src/features/appointment/widgets/appointment_tile.dart';
import 'package:flutter/material.dart';
import '../models.dart';

class TodayAppointmentListPage extends StatefulWidget {
  const TodayAppointmentListPage({Key? key}) : super(key: key);

  @override
  _TodayAppointmentListPageState createState() =>
      _TodayAppointmentListPageState();
}

class _TodayAppointmentListPageState extends State<TodayAppointmentListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<List<Appointment>>(
            stream: AppointmentRepository.todayAppointments(
                Authenticator.of(context).id),
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
    );;
  }
}
