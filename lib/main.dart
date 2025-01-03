import 'package:flutter/material.dart';
import 'package:foode/Welcome/Slpash.dart';
import 'package:foode/Widget/AppWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://bpeqayuadpfyzempcsqj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJwZXFheXVhZHBmeXplbXBjc3FqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU1ODQ0MjQsImV4cCI6MjA1MTE2MDQyNH0.gEqLLabPIQFVDC0nFYHZtd1TjQ_z38DkNp5q1Bn-L6E',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foody',
      theme: ThemeData(

        colorScheme: const ColorScheme.light(primary: AppWidget.primaryColor),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}

