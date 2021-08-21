import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<dynamic> push(context, p) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (c) => p));

pop(context, [r]) => Navigator.of(context).pop(r);
