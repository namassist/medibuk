import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/pages/medical_record_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Record System',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const OptimizedMedicalRecordPage(medicalRecordId: '1268301'),
    );
  }
}
