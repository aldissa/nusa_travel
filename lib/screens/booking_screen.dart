import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/tour_package.dart';

class BookingScreen extends StatefulWidget {
  final TourPackage package;

  const BookingScreen({super.key, required this.package});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  static const Color _ocean = Color(0xFF0369A1);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _participantsController = TextEditingController(text: '1');
  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _participantsController.dispose();
    super.dispose();
  }

  // Jumlah peserta dari input (0 jika kosong/tidak valid)
  int get _participants => int.tryParse(_participantsController.text) ?? 0;

  // Total biaya = harga per pax x jumlah peserta
  int get _total => widget.package.price * _participants;

  /// Format tanggal tanpa package intl. Contoh: "25 Desember 2026"
  String _formatDate(DateTime date) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// Dialog konfirmasi pembatalan. Mengembalikan true jika pengguna memilih "Ya".
  Future<bool> _confirmCancel() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded,
            color: Color(0xFFBA1A1A), size: 36),
        title: const Text('Batalkan pemesanan?'),
        content: const Text(
          'Data pemesanan yang sudah Anda isi akan hilang jika Anda kembali sekarang.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Tidak'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFBA1A1A),
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Ya, Batalkan'),
          ),
        ],
      ),
    );
    return result ?? false; // dialog ditutup di luar tombol -> dianggap "Tidak"
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null && mounted) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submit() {
    // validate() menjalankan semua validator; false jika ada yang tidak valid.
    if (!_formKey.currentState!.validate()) return;

    final result = <String, dynamic>{
      'name': _nameController.text.trim(),
      'participants': _participants,
      'date': _selectedDate,
      'total': _total,
      'packageId': widget.package.id,
    };

    // Kembali ke Detail sambil membawa hasil pemesanan.
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    // PopScope: canPop false -> tombol Back (sistem maupun panah AppBar)
    // tidak langsung menutup halaman, tetapi memanggil onPopInvokedWithResult.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // sudah tertutup, tidak perlu apa-apa
        final shouldLeave = await _confirmCancel();
        if (shouldLeave && context.mounted) {
          // Navigator.pop langsung tidak melewati PopScope.
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            'Form Pemesanan',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ringkasan paket
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.package.imageUrl,
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: 72,
                            height: 72,
                            color: const Color(0xFFE2E8F0),
                            child: const Icon(Icons.broken_image_rounded,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.package.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.package.formattedPrice} / pax',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: _ocean,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Data Wisatawan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),

                // Nama
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _inputDecoration(
                    'Nama Lengkap Pemesan',
                    Icons.person_rounded,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Jumlah peserta
                TextFormField(
                  controller: _participantsController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: _inputDecoration(
                    'Jumlah Peserta',
                    Icons.groups_rounded,
                  ),
                  // Hitung ulang total setiap kali angka berubah
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Jumlah peserta wajib diisi';
                    }
                    final count = int.tryParse(value);
                    if (count == null || count < 1) {
                      return 'Jumlah peserta minimal 1';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Tanggal keberangkatan (FormField agar ikut divalidasi)
                FormField<DateTime>(
                  validator: (_) =>
                      _selectedDate == null ? 'Tanggal wajib dipilih' : null,
                  builder: (field) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        await _pickDate();
                        field.didChange(_selectedDate); // hapus pesan error
                      },
                      child: InputDecorator(
                        decoration: _inputDecoration(
                          'Tanggal Keberangkatan',
                          Icons.calendar_month_rounded,
                        ).copyWith(errorText: field.errorText),
                        child: Text(
                          _selectedDate == null
                              ? 'Pilih tanggal'
                              : _formatDate(_selectedDate!),
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedDate == null
                                ? const Color(0xFF707881)
                                : const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Ringkasan biaya
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF004B73),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'RINGKASAN BIAYA',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: Color(0xB3FFFFFF),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatRupiah(_total),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.package.formattedPrice} x $_participants pax',
                        style: const TextStyle(color: Color(0xB3FFFFFF)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Tombol konfirmasi
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: _ocean,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: _submit,
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Konfirmasi Pesanan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Gaya input seragam untuk semua field
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: _ocean),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _ocean, width: 2),
      ),
    );
  }
}