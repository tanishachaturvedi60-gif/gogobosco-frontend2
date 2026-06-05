import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gogobosco/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vbzqkewvyaovsxpbxihf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZienFrZXd2eWFvdnN4cGJ4aWhmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODAxNjQ5NzcsImV4cCI6MjA5NTc0MDk3N30.Ct2rIIEb-JshT3dpuwNq-pEOGrwPPSVUuAYKioq3K3I',
  );
  runApp(const GoGoBoscoApp());
}
