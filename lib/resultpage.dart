import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class result extends StatelessWidget {
  const result({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset('assets/animation.json')),
    );
  }
}
