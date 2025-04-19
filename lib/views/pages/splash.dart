import 'package:flutter/material.dart';
import 'home_page.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/images/logo.png', width: 600)),
    );
  }
}
