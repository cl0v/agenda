import 'package:agenda/authenticator_provider.dart';
import 'package:agenda/src/features/appointment/models.dart';
import 'package:flutter/material.dart';

import '../repositories.dart';

class CreateAppointmentButton extends StatelessWidget {
  const CreateAppointmentButton({required this.appointment});
  final Appointment Function() appointment;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        final userid = Authenticator.of(context).id;
        AppointmentRepository.create(userid, appointment.call());
      },
      icon: Icon(Icons.add),
      label: Text('Agendar'),
    );
  }
}
