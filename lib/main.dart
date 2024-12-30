import 'package:flutter/material.dart';
import 'package:foode/Anthitcation/Pages/Login.dart';
import 'package:foode/Widget/AppWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://ystryaeejyalscuyxnfi.supabase.co';
const supabaseKey = String.fromEnvironment('SUPABASE_KEY');


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ystryaeejyalscuyxnfi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlzdHJ5YWVlanlhbHNjdXl4bmZpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU1MDk0NzgsImV4cCI6MjA1MTA4NTQ3OH0.hKSFj-42N9anTIl7L4_0ZmvEiaK_PnTOCyd5svWP0kM',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foody',
      theme: ThemeData(

        colorScheme: const ColorScheme.light(primary: AppWidget.primaryColor),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

