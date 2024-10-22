import 'package:checklist_app/core/helper/injection.dart';
import 'package:checklist_app/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyA56KSjAMEUZbYb7LQ2KU-iT996nC5Er4k",
        authDomain: "mobilechecklist-e9277.firebaseapp.com",
        projectId: "mobilechecklist-e9277",
        storageBucket: "mobilechecklist-e9277.appspot.com",
        messagingSenderId: "32690717747",
        appId: "1:32690717747:web:ef647f62d9a354f1754f46",
        measurementId: "G-YBHWSS02PN"),
  );
  await configureInjection();
  runApp(const MyApp());
}
