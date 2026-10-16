import 'package:flutter/material.dart';

import '../models/tour_package.dart';

class BookingScreen extends StatelessWidget {
  final TourPackage package;

  const BookingScreen({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking (sementara)')),
      body: Center(
        child: ElevatedButton(
          // Mengirim hasil ke Detail lewat Navigator.pop(context, hasil)
          onPressed: () => Navigator.pop(context, {
            'name': 'Budi Santoso',
            'participants': 2,
          }),
          child: const Text('Konfirmasi (tes)'),
        ),
      ),
    );
  }
}