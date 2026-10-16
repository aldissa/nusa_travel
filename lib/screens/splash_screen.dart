import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.home),
          child: const Text('Mulai Eksplorasi'),
        ),
      ),
    );
  }
}