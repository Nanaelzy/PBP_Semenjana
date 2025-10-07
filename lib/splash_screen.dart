import 'package:flutter/material.dart';
import 'package:semenjana/login_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/flattn240.png', width: 220, height: 220),
            const SizedBox(height: 10),
            const Text(
              'Semenjana',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4282AA),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'by Helena Kusuma Wardhani',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
            LoadingAnimationWidget.staggeredDotsWave(
              color: const Color(0xFF4282AA),
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
