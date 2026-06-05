import 'package:flutter/material.dart';
import 'package:gogobosco/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vbzqkewvyaovsxpbxihf.supabase.co',
    anonKey: 'sb_publishable_hMzpS2kz07ZT9-r93zf3_A_yCZ9Rofr',
  );
  runApp(const GoGoBoscoApp());
}
