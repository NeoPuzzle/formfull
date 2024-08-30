import 'package:flutter/material.dart';
import './src/theme/theme.dart';
import './src/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login & Register',
      theme: appTheme(),
      home: const LoginScreen(),
    );
  }
}








