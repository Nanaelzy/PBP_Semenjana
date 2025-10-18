import 'package:flutter/material.dart';
import 'package:rating_and_feedback_collector/rating_and_feedback_collector.dart';
import 'home_page.dart';

// Definisi Warna Kustom
const Color _primaryColor = Color(0xFF1E88E5); // Biru yang Lebih Berenergi
const Color _successGreen = Color(0xFF4CAF50);

class OrderConfirmation extends StatefulWidget {
  final String orderId;
  final String returnMethod;

  const OrderConfirmation({
    super.key,
    this.orderId = 'RNT-20251015-123456',
    this.returnMethod = 'Dijemput Kurir',
  });

  @override
  State<OrderConfirmation> createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  double _rating = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Header Sukses (Area Atas dengan Ikon dan Pesan)
              _buildSuccessHeader(context),

              // 2. Detail Pesanan (Informasi ID dan Pengembalian)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildOrderDetailCard(context),
                    const SizedBox(height: 30),
                  ],
                ),
              ),

              // 3. Area Aksi (Tombol & Rating)
              _buildActionsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widget 1: Header Sukses ---
  Widget _buildSuccessHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      // Warna Latar Belakang Hijau Muda untuk menonjolkan sukses
      color: _successGreen.withOpacity(0.05),
      child: Column(
        children: [
          // Ikon Cek yang lebih besar
          const Icon(
            Icons.check_circle_outline,
            color: _successGreen,
            size: 80,
          ),
          const SizedBox(height: 20),
          const Text(
            'Pembayaran Berhasil!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Pesanan Anda sedang kami proses. Cek email Anda untuk detail lengkap.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget 2: Detail Pesanan (Card) ---
  Widget _buildOrderDetailCard(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan Pesanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 25),

            // Detail 1: ID Pesanan
            _buildDetailRow(
              'ID Pesanan',
              widget.orderId,
              icon: Icons.receipt_long,
            ),
            const SizedBox(height: 15),

            // Detail 2: Metode Pengembalian
            _buildDetailRow(
              'Metode Pengembalian',
              widget.returnMethod,
              icon: Icons.local_shipping,
              isHighlighted: true, // Menonjolkan detail ini
            ),
            const SizedBox(height: 5),
            Text(
              'Kurir akan menjemput barang di akhir masa sewa.',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  // Baris Detail Umum
  Widget _buildDetailRow(
    String label,
    String value, {
    required IconData icon,
    bool isHighlighted = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _primaryColor, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                  color: isHighlighted ? _primaryColor : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Helper Widget 3: Area Aksi (Tombol & Rating) ---
  Widget _buildActionsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tombol Kembali ke Home
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(userEmail: 'User'),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(Icons.home, color: Colors.white),
              label: const Text(
                'Kembali ke Home',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Rating Bintang
          const Text(
            'Bagaimana pengalamanmu dengan aplikasi ini?',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 10),
          _buildFunctionalRatingBar(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFunctionalRatingBar() {
    return RatingBar(
      iconSize: 40,
      allowHalfRating: true,
      filledIcon: Icons.star,
      halfFilledIcon: Icons.star_half,
      emptyIcon: Icons.star_border,
      filledColor: Colors.amber,
      emptyColor: Colors.grey,
      currentRating: _rating,
      onRatingChanged: (rating) {
        // 🔥 MEMPERBARUI STATE SAAT PENGGUNA MEMBERI RATING
        setState(() {
          _rating = rating;
        });
        // Opsional: Tampilkan notifikasi atau kirim data rating ke server
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rating disimpan: $_rating bintang')),
        );
      },
    );
  }
}
