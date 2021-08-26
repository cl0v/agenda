import 'package:agenda/authenticator_provider.dart';
import 'package:agenda/src/features/service/models/service.dart';
import 'package:flutter/material.dart';

import 'package:agenda/repositories/service.dart';

class ServiceListTile extends StatelessWidget {
  final ServiceModel service;

  const ServiceListTile({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: service.value == -1
      //     ? Icon(
      //         Icons.warning,
      //         color: Colors.yellow[800],
      //       )
      //     : null,
      title: Text(
        service.title,
      ),
      // subtitle: Text(
      //   service.value == -1
      //       ? 'Não fornecido'
      //       : service.value.toStringAsFixed(2),
      // ),
    );
  }
}
