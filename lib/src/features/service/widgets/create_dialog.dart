
import 'package:agenda/repositories/service.dart';
import 'package:agenda/src/features/service/models/service.dart';
import 'package:flutter/material.dart';

import '../../../../authenticator_provider.dart';

class CreateServiceDialog extends StatelessWidget {
  CreateServiceDialog({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  ServiceModel get service => ServiceModel(
        title: titleController.text,
      );

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
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Titulo'),
                    controller: titleController,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     keyboardType: TextInputType.number,
                //     decoration: InputDecoration(labelText: 'Valor'),
                //     controller: valueController,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Adicionar"),
                    onPressed: () async {
                      print(service);
                      final uid = Authenticator.of(context).id;
                      ServiceRepository.create(uid, service);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
