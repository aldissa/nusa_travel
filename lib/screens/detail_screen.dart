import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import 'booking_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  static const Color _ocean = Color(0xFF0369A1);
  static const Color _teal = Color(0xFF0D9488);

  /// Buka Booking dengan `await Navigator.push()`.
  /// Kode setelah `await` baru jalan ketika Booking sudah ditutup (pop),
  /// dan `result` berisi data yang dikirim lewat Navigator.pop(context, hasil).
  Future<void> _openBooking(BuildContext context, TourPackage package) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => BookingScreen(package: package),
      ),
    );

    // Pastikan widget masih aktif sebelum memakai context setelah await.
    if (!context.mounted) return;

    // result == null berarti pemesanan dibatalkan (pengguna menekan Back).
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: _teal,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 4),
          content: Text(
            'Pemesanan atas nama ${result['name']} berhasil',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ambil objek TourPackage yang dikirim dari Home lewat `arguments`.
    final package =
        ModalRoute.of(context)!.settings.arguments as TourPackage;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Detail Paket',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama
            AspectRatio(
              aspectRatio: 16 / 11,
              child: Image.network(
                package.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: const Color(0xFFE2E8F0),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFE2E8F0),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.broken_image_rounded,
                    size: 56,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lokasi + rating
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded,
                          size: 18, color: _teal),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          package.location,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _teal,
                          ),
                        ),
                      ),
                      const Icon(Icons.star_rounded,
                          size: 20, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        package.rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Judul
                  Text(
                    package.title,
                    style: const TextStyle(
                      fontSize: 26,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Harga
                  Text.rich(
                    TextSpan(
                      text: package.formattedPrice,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: _ocean,
                      ),
                      children: const [
                        TextSpan(
                          text: ' / pax',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF707881),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Fasilitas (hanya tampil jika ada)
                  if (package.facilities.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Fasilitas Termasuk',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final item in package.facilities)
                          Chip(
                            avatar: const Icon(Icons.check_circle_rounded,
                                size: 18, color: _teal),
                            label: Text(item),
                            backgroundColor: const Color(0xFFE0F2FE),
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                          ),
                      ],
                    ),
                  ],

                  // Deskripsi
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Deskripsi Paket',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          package.description,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF3F4850),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bar bawah: harga + tombol pesan
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x1A0284C7),
              blurRadius: 16,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Harga per pax',
                      style: TextStyle(fontSize: 12, color: Color(0xFF707881)),
                    ),
                    Text(
                      package.formattedPrice,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: _ocean,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: _ocean,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () => _openBooking(context, package),
                    child: const Text('Pesan Sekarang'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}