import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

push(context, p) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (c) => p));

pop(context) => Navigator.of(context).pop();
