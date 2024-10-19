import 'package:antar_cash/cubit/observer.dart';
import 'package:antar_cash/firebase_options.dart';
import 'package:antar_cash/screens/home_screen.dart';
import 'package:antar_cash/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser == null;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user ? LoginScreen() : HomeScreen(),
    );
  }
}
