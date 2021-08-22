import 'package:agenda/models/service.dart';
import 'package:agenda/utils/navigator.dart';
import 'package:flutter/material.dart';

import 'package:agenda/repositories/service.dart';

class ServiceListPage extends StatefulWidget {
  const ServiceListPage(
      {Key? key, required this.uid, this.selectedServices = const []})
      : super(key: key);
  final String uid;
  final List<ServiceModel> selectedServices;

  @override
  _ServiceListPageState createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  late final ServiceRepository repository;

  List<ServiceModel> selectedServices = [];

  onAdd(ServiceModel e) {
    selectedServices.add(e);
  }

  onRemove(ServiceModel e) {
    selectedServices.add(e);
  }

  @override
  void initState() {
    repository = ServiceRepository(widget.uid);
    selectedServices = widget.selectedServices;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pop(context, selectedServices);
        },
        child: Icon(Icons.check),
      ),
      appBar: AppBar(
        title: Text('Serviços'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CreateServicePopUp(
                        repository: repository,
                      );
                    });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<ServiceModel>>(
          stream: repository.read(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final List<ServiceModel> l = snapshot.data ?? [];
            return ListView(
              children: l
                  .map((e) => ServiceCheckboxTile(
                    repository: repository,
                        service: e,
                        onAdd: () => onAdd(e),
                        onRemove: () => onRemove(e),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

class ServiceCheckboxTile extends StatefulWidget {
  const ServiceCheckboxTile(
      {Key? key,
      required this.service,
      required this.onAdd,
      required this.repository,
      required this.onRemove})
      : super(key: key);
  final ServiceModel service;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final ServiceRepository repository;


  @override
  _ServiceCheckboxTileState createState() => _ServiceCheckboxTileState();
}

class _ServiceCheckboxTileState extends State<ServiceCheckboxTile> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CreateServicePopUp(
                        repository: widget.repository,
                        // serviceModel: widget.service,
                      );
                    });
      },
      leading: widget.service.value == -1
          ? Icon(
              Icons.warning,
              color: Colors.yellow[800],
            )
          : null,
      title: Text(widget.service.title),
      subtitle: Text(widget.service.value == -1
          ? 'Não fornecido'
          : widget.service.value.toStringAsFixed(2)),
      trailing: Checkbox(
        onChanged: (v) {
          if (v != null) v ? widget.onAdd() : widget.onRemove();
          setState(() {
            _checked = v ?? _checked;
          });
        },
        value: _checked,
      ),
    );
  }
}

class CreateServicePopUp extends StatelessWidget {
  CreateServicePopUp({
    Key? key,
    required this.repository,
    // this.serviceModel,
  }) : super(key: key);
  final ServiceRepository repository;
  // final ServiceModel? serviceModel;
  final _formKey = GlobalKey<FormState>();

  TextEditingController get titleController =>
      TextEditingController(
        // text: serviceModel?.title
        );
  TextEditingController get valueController =>
      TextEditingController(
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
                    onPressed: () {
                      repository.create(service);
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
