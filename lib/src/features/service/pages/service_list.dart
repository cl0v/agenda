import 'package:agenda/authenticator.dart';
import 'package:agenda/src/features/service/models/service.dart';
import 'package:agenda/src/features/service/widgets/checkbox_tile.dart';
import 'package:flutter/material.dart';

import 'package:agenda/repositories/service.dart';

class ServiceListPage extends StatefulWidget {
  // Essa página não escolhe os services, apenas cadastra e edita.
  const ServiceListPage({Key? key, this.selectedServices = const []})
      : super(key: key);
  final String uid = '0000';
  final List<ServiceModel> selectedServices;

  @override
  _ServiceListPageState createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serviços'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CreateServicePopUp();
                    });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<ServiceModel>>(
          stream: ServiceRepository.readAll(Authenticator.of(context).id),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final List<ServiceModel> l = snapshot.data ?? [];
            return ListView(
              children: l
                  .map((e) => ServiceListTile(
                        service: e,
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

class ServiceListTile extends StatelessWidget {
  final ServiceModel service;

  const ServiceListTile({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: service.value == -1
          ? Icon(
              Icons.warning,
              color: Colors.yellow[800],
            )
          : null,
      title: Text(service.title),
      subtitle: Text(
        service.value == -1
            ? 'Não fornecido'
            : service.value.toStringAsFixed(2),
      ),
    );
  }
}

class CreateServicePopUp extends StatelessWidget {
  CreateServicePopUp({
    Key? key,
    // this.serviceModel,
  }) : super(key: key);
  // final ServiceModel? serviceModel;
  final _formKey = GlobalKey<FormState>();

  TextEditingController get titleController => TextEditingController(
      // text: serviceModel?.title
      );
  TextEditingController get valueController => TextEditingController(
      // text: serviceModel?.value.toString()
      );

  ServiceModel get service => ServiceModel(
        title: titleController.text,
        value: double.parse(valueController.text),
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Valor'),
                    controller: valueController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Adicionar"),
                    onPressed: () async {
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
