import 'package:flutter/material.dart';

import '../models/tour_package.dart';

/// Halaman Riwayat Pesanan.
/// Menampilkan daftar pesanan dummy dengan status dan ringkasan.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const Color _ocean = Color(0xFF0369A1);

  @override
  Widget build(BuildContext context) {
    return _dummyOrders.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F2FE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.receipt_long_rounded,
                    size: 48,
                    color: _ocean,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Belum Ada Pesanan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pesanan Anda akan tampil di sini.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF707881),
                  ),
                ),
              ],
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _dummyOrders.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final order = _dummyOrders[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    // Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        order['imageUrl'] as String,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          width: 64,
                          height: 64,
                          color: const Color(0xFFE2E8F0),
                          child: const Icon(Icons.broken_image_rounded,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Detail pesanan
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order['title'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${order['participants']} pax • ${order['date']}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF707881),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order['total'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _ocean,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Badge status
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: order['statusColor'] as Color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        order['status'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: order['statusTextColor'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}

/// Data dummy riwayat pesanan.
final List<Map<String, dynamic>> _dummyOrders = [
  {
    'title': 'Pesona Bahari Raja Ampat',
    'imageUrl': dummyTourPackages[0].imageUrl,
    'participants': 2,
    'date': '15 Nov 2026',
    'total': formatRupiah(6850000 * 2),
    'status': 'Selesai',
    'statusColor': const Color(0xFFD1FAE5),
    'statusTextColor': const Color(0xFF065F46),
  },
  {
    'title': 'Heritage & Sunset Candi Prambanan',
    'imageUrl': dummyTourPackages[3].imageUrl,
    'participants': 4,
    'date': '02 Okt 2026',
    'total': formatRupiah(1850000 * 4),
    'status': 'Selesai',
    'statusColor': const Color(0xFFD1FAE5),
    'statusTextColor': const Color(0xFF065F46),
  },
  {
    'title': 'Eksotisme Labuan Bajo & Komodo',
    'imageUrl': dummyTourPackages[1].imageUrl,
    'participants': 1,
    'date': '25 Des 2026',
    'total': formatRupiah(4950000),
    'status': 'Menunggu',
    'statusColor': const Color(0xFFFEF3C7),
    'statusTextColor': const Color(0xFF92400E),
  },
];
