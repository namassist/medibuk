import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/config/environment.dart';
import 'package:medibuk/main.dart';

void main() {
  EnvManager.instance.initialize(Environment.production());
  runApp(const ProviderScope(child: MyApp()));
}
