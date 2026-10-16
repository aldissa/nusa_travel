import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/splash_screen.dart';

/// Pusat konfigurasi navigasi aplikasi.
class AppRoutes {
  AppRoutes._(); // mencegah class ini dibuat objeknya

  // Konstanta nama route
  static const String splash = '/';
  static const String home = '/home';
  static const String detail = '/detail';

  /// Route statis tanpa data -> dipakai pada parameter `routes`.
  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        home: (context) => const HomeScreen(),
      };

  /// Route yang butuh arguments -> dipakai pada parameter `onGenerateRoute`.
  /// Hanya dipanggil untuk nama route yang TIDAK ada di `routes`.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == detail) {
      // Validasi tipe arguments supaya tidak crash saat dibaca di DetailScreen.
      if (settings.arguments is TourPackage) {
        return MaterialPageRoute(
          settings: settings, // penting: agar ModalRoute.of(context) membawa arguments
          builder: (context) => const DetailScreen(),
        );
      }
    }
    // Return null -> Flutter akan memanggil onUnknownRoute.
    return null;
  }

  /// Fallback untuk route yang tidak dikenal -> halaman 404.
  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => NotFoundScreen(routeName: settings.name),
    );
  }
}