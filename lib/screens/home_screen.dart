import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Pindah ke Detail sambil mengirim objek TourPackage lewat `arguments`.
  void _openDetail(BuildContext context, TourPackage package) {
    Navigator.pushNamed(
      context,
      AppRoutes.detail,
      arguments: package,
    );
  }

  /// Logout: hapus SELURUH riwayat halaman, lalu buka Splash.
  /// Predicate `(route) => false` berarti semua route di stack dihapus.
  void _logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.splash,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'NusaTravel',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF0369A1),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFFFDAD6),
            ),
            icon: const Icon(Icons.logout_rounded, color: Color(0xFFBA1A1A)),
            onPressed: () => _logout(context),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: dummyTourPackages.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final package = dummyTourPackages[index];
          return _PackageCard(
            package: package,
            onTap: () => _openDetail(context, package),
          );
        },
      ),
    );
  }
}

/// Kartu satu paket wisata (gambar, lokasi, rating, judul, harga).
class _PackageCard extends StatelessWidget {
  final TourPackage package;
  final VoidCallback onTap;

  const _PackageCard({required this.package, required this.onTap});

  static const Color _ocean = Color(0xFF0369A1);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.antiAlias, // agar gambar ikut membulat
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar + badge lokasi & rating di atasnya
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Image.network(
                    package.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // Tampilkan indikator saat gambar masih dimuat
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: const Color(0xFFE2E8F0),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      );
                    },
                    // Mencegah crash jika gambar gagal dimuat
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFE2E8F0),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image_rounded,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 12,
                  child: _Badge(
                    icon: Icons.location_on_rounded,
                    iconColor: const Color(0xFF0D9488),
                    text: package.location,
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: _Badge(
                    icon: Icons.star_rounded,
                    iconColor: Colors.amber,
                    text: package.rating.toString(),
                  ),
                ),
              ],
            ),

            // Isi kartu
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    package.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Color(0xFF3F4850),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'MULAI DARI',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                color: Color(0xFF707881),
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: package.formattedPrice,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: _ocean,
                                ),
                                children: const [
                                  TextSpan(
                                    text: ' / pax',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF707881),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: _ocean,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                        ),
                        onPressed: onTap,
                        iconAlignment: IconAlignment.end,
                        icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                        label: const Text('Lihat Detail'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Badge kecil berlatar putih (dipakai untuk lokasi dan rating).
class _Badge extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const _Badge({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xE6FFFFFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}