import 'package:checklist_app/my_app.dart';
import 'package:checklist_app/utils/shared_preferences_manager.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefsManager = SharedPreferencesManager();
  await sharedPrefsManager.init();
  runApp(const MyApp());
}
