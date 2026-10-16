import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Warna dari design system NusaTravel
  static const Color _oceanDark = Color(0xFF0369A1);
  static const Color _ocean = Color(0xFF0284C7);
  static const Color _teal = Color(0xFF0D9488);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        // Gradasi biru laut -> teal, sesuai desain
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_oceanDark, _ocean, _teal],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(flex: 3),

                // Logo: kotak putih membulat berisi ikon
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    color: const Color(0xE6FFFFFF), 
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 24,
                        offset: Offset(0, 12),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.explore_rounded,
                    size: 72,
                    color: _teal,
                  ),
                ),
                const SizedBox(height: 32),

                // Nama aplikasi
                const Text(
                  'NusaTravel',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Jelajahi Keindahan Nusantara Bersama Kami',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Color(0xCCFFFFFF),
                  ),
                ),

                const Spacer(flex: 4),

                // Tombol "Mulai Eksplorasi"
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _oceanDark,
                      elevation: 6,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.only(left: 24, right: 12),
                    ),
                    onPressed: () {
                      // pushReplacementNamed: Splash DIGANTI oleh Home,
                      // sehingga tombol Back dari Home tidak kembali ke Splash.
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    },
                    child: const Row(
                      children: [
                        // Spacer kiri selebar ikon agar teks tetap di tengah
                        SizedBox(width: 40),
                        Expanded(
                          child: Text(
                            'Mulai Eksplorasi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFFCCE5FF),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: _oceanDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}