
// import 'package:agenda/src/features/service/models/service.dart';
// import 'package:flutter/material.dart';

// class ServiceCheckboxTile extends StatefulWidget {
//   const ServiceCheckboxTile(
//       {Key? key,
//       required this.service,
//       required this.onAdd,
//       required this.onRemove})
//       : super(key: key);
//   final ServiceModel service;
//   final VoidCallback onAdd;
//   final VoidCallback onRemove;

//   @override
//   _ServiceCheckboxTileState createState() => _ServiceCheckboxTileState();
// }

// class _ServiceCheckboxTileState extends State<ServiceCheckboxTile> {
//   bool _checked = false;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: widget.service.value == -1
//           ? Icon(
//               Icons.warning,
//               color: Colors.yellow[800],
//             )
//           : null,
//       title: Text(widget.service.title),
//       subtitle: Text(widget.service.value == -1
//           ? 'Não fornecido'
//           : widget.service.value.toStringAsFixed(2)),
//       trailing: Checkbox(
//         onChanged: (v) {
//           if (v != null) v ? widget.onAdd() : widget.onRemove();
//           setState(() {
//             _checked = v ?? _checked;
//           });
//         },
//         value: _checked,
//       ),
//     );
//   }
// }
