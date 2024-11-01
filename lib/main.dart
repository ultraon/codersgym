import 'package:flutter/material.dart';
import 'package:myapp/app.dart';
import 'package:myapp/injection.dart';

void main() {
  intializeDependencies();
  runApp(const App());
}
