class TourPackage {
  final String id;
  final String title;
  final String description;
  final int price; // harga per pax, dalam Rupiah
  final String imageUrl;

  // Field tambahan (opsional)
  final String location;
  final double rating;
  final List<String> facilities;

  const TourPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.location = 'Indonesia',
    this.rating = 4.8,
    this.facilities = const [],
  });

  /// Contoh hasil: "Rp 6.850.000"
  String get formattedPrice => formatRupiah(price);
}

/// Format angka ke Rupiah tanpa package intl.
/// Regex menyisipkan titik setiap 3 digit dari belakang.
String formatRupiah(int value) {
  final digits = value.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (match) => '.',
      );
  return 'Rp $digits';
}

/// Data dummy (4 paket wisata).
const List<TourPackage> dummyTourPackages = [
  TourPackage(
    id: 'ra-01',
    title: 'Pesona Bahari Raja Ampat',
    description:
        'Jelajahi surga bawah laut dunia di Kepulauan Wayag, Misool, dan '
        'Danau Ubur-ubur tanpa sengat. Termasuk snorkeling gear, homestay '
        'terapung, dan kapal cepat antar pulau.',
    price: 6850000,
    imageUrl:
        'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf?auto=format&fit=crop&w=800&q=80',
    location: 'Papua Barat Daya',
    rating: 4.9,
    facilities: ['Snorkeling Gear', 'Homestay Terapung', 'Speedboat Wayag', 'Guide Lokal'],
  ),
  TourPackage(
    id: 'lb-02',
    title: 'Eksotisme Labuan Bajo & Komodo',
    description:
        'Pelayaran liveaboard 3 hari 2 malam dengan kapal phinisi, trekking '
        'Pulau Padar saat sunrise, bertemu komodo di Pulau Rinca, dan '
        'bersantai di Pink Beach.',
    price: 4950000,
    imageUrl:
        'https://images.unsplash.com/photo-1570789210967-2cac24afeb00?auto=format&fit=crop&w=800&q=80',
    location: 'Nusa Tenggara Timur',
    rating: 4.9,
    facilities: ['Kapal Phinisi', 'Makan 3x Sehari', 'Ranger Komodo', 'Alat Snorkeling'],
  ),
  TourPackage(
    id: 'ub-03',
    title: 'Budaya & Alam Spiritual Ubud Bali',
    description:
        'Pengalaman autentik menyusuri sawah terasering Tegalalang, kelas '
        'yoga meditatif, pembersihan diri di Tirta Empul, dan pertunjukan '
        'Tari Kecak.',
    price: 2450000,
    imageUrl:
        'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&w=800&q=80',
    location: 'Bali',
    rating: 4.8,
    facilities: ['Villa Private', 'Kelas Yoga', 'Antar-Jemput', 'Tiket Tari Kecak'],
  ),
  TourPackage(
    id: 'pb-04',
    title: 'Heritage & Sunset Candi Prambanan',
    description:
        'Wisata sejarah warisan dunia UNESCO di Candi Borobudur dan '
        'Prambanan, Lava Tour Jeep Merapi, serta kuliner gudeg khas '
        'Malioboro, Yogyakarta.',
    price: 1850000,
    imageUrl:
        'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?auto=format&fit=crop&w=800&q=80',
    location: 'D.I. Yogyakarta',
    rating: 4.7,
    facilities: ['Tiket Candi', 'Jeep Lava Tour', 'Guide Sejarah', 'Hotel Bintang 3'],
  ),
];