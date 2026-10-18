import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

/// Halaman Profil sederhana.
/// Menampilkan info akun dummy dan tombol logout.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color _ocean = Color(0xFF0369A1);
  static const Color _teal = Color(0xFF0D9488);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 12),

          // Avatar
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_ocean, _teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 56,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Pengelana Nusantara',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'traveler@nusatravel.id',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF707881),
            ),
          ),
          const SizedBox(height: 28),

          // Info card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Column(
              children: [
                _InfoRow(
                  icon: Icons.phone_rounded,
                  label: 'Telepon',
                  value: '+62 xxx-xxxx-xxxx',
                ),
                Divider(height: 24),
                _InfoRow(
                  icon: Icons.location_on_rounded,
                  label: 'Kota',
                  value: 'Sukabumi, Indonesia',
                ),
                Divider(height: 24),
                _InfoRow(
                  icon: Icons.calendar_month_rounded,
                  label: 'Bergabung Sejak',
                  value: 'Oktober 2026',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Statistik singkat
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: _StatItem(
                    value: '3',
                    label: 'Perjalanan',
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: VerticalDivider(),
                ),
                Expanded(
                  child: _StatItem(
                    value: '5',
                    label: 'Destinasi',
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: VerticalDivider(),
                ),
                Expanded(
                  child: _StatItem(
                    value: '12',
                    label: 'Foto',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Tombol logout
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFBA1A1A),
                side: const BorderSide(color: Color(0xFFFFDAD6)),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.logout_rounded),
              label: const Text(
                'Keluar / Logout',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.splash,
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Baris informasi di kartu profil.
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF0369A1)),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF707881),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Item statistik (angka + label).
class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0369A1),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF707881),
          ),
        ),
      ],
    );
  }
}
