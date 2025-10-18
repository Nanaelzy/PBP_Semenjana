import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Ubah StatelessWidget menjadi StatefulWidget
class PaymentSelectionModal extends StatefulWidget {
  final double amountDue;

  const PaymentSelectionModal({super.key, required this.amountDue});

  @override
  State<PaymentSelectionModal> createState() => _PaymentSelectionModalState();
}

class _PaymentSelectionModalState extends State<PaymentSelectionModal> {
  // 🔥 STATE UNTUK MELACAK TAB PEMBAYARAN AKTIF
  String _activeTab = 'Kartu'; // Default: Kartu

  // Asumsi untuk DropdownButtonFormField (Negara)
  String? _selectedCountry = 'Indonesia';

  // Helper untuk memformat total (Sama seperti kode aslimu)
  String _formatAmount(double amount) {
    try {
      final currencyFormatter = NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp ',
        decimalDigits: 0,
      );
      return currencyFormatter.format(amount);
    } catch (e) {
      // Menggunakan widget.amountDue untuk mengakses properti dari StatefulWidget
      return 'Rp ${widget.amountDue.toStringAsFixed(0)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Pilih Pembayaran'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: const BoxConstraints(maxWidth: 500),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.grey, width: 0.5),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Jumlah Terutang (Menggunakan widget.amountDue)
                  _buildAmountDueHeader(widget.amountDue),
                  const SizedBox(height: 20),

                  // Tab Metode Pembayaran
                  _buildPaymentTabs(),
                  const SizedBox(height: 20),

                  // 🔥 Konten Formulir Berdasarkan Tab Aktif
                  if (_activeTab == 'Kartu') _buildCardPaymentForm(context),
                  if (_activeTab == 'E-Wallet')
                    _buildPlaceholderForm('E-Wallet'),
                  if (_activeTab == 'Bayar Nanti')
                    _buildPlaceholderForm('Bayar Nanti'),

                  const SizedBox(height: 30),

                  // Tombol Bayar
                  _buildPayNowButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- HELPER METHODS (Disesuaikan untuk State) ----------------

  Widget _buildAmountDueHeader(double amount) {
    return Column(
      children: [
        const Text('Jumlah Terutang', style: TextStyle(color: Colors.grey)),
        Text(
          _formatAmount(amount),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPaymentTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPaymentTabItem('Kartu', Icons.credit_card),
        _buildPaymentTabItem('E-Wallet', Icons.account_balance_wallet),
        _buildPaymentTabItem('Bayar Nanti', Icons.schedule),
      ],
    );
  }

  // 🔥 WIDGET YANG DAPAT DIKLIK (InkWell)
  Widget _buildPaymentTabItem(String label, IconData icon) {
    final bool isActive = _activeTab == label;

    return InkWell(
      onTap: () {
        // 🔥 MEMPERBARUI STATE SAAT DIKLIK
        setState(() {
          _activeTab = label;
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isActive ? Colors.blue : Colors.grey.shade300,
                  width: 2,
                ),
                color: isActive ? Colors.blue.withOpacity(0.1) : Colors.white,
              ),
              child: Icon(icon, color: isActive ? Colors.blue : Colors.black54),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.blue : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 FORMULIR KARTU (Termasuk Dropdown Negara)
  Widget _buildCardPaymentForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.lock, color: Colors.green, size: 16),
            const SizedBox(width: 8),
            Text(
              'Checkout Aman 1-klik dengan Link',
              style: TextStyle(
                color: Colors.green.shade700,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),

        // Input Nomor Kartu
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Nomor Kartu',
            suffixIcon: Icon(Icons.credit_card_outlined),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          ),
        ),
        const SizedBox(height: 10),

        // Input Tanggal Kedaluwarsa dan CVC
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'Tanggal Kedaluwarsa (BB/TT)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Kode CVC',
                  suffixIcon: Icon(Icons.credit_card_outlined, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // 🔥 Dropdown Input Negara (Solusi UX terbaik)
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Negara',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10,
            ),
          ),
          value: _selectedCountry,
          icon: const Icon(Icons.arrow_drop_down),
          isExpanded: true,
          items:
              <String>[
                'Indonesia',
                'Singapura',
                'Malaysia',
                'Thailand',
                'Lainnya',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCountry = newValue; // Memperbarui state
            });
          },
        ),
      ],
    );
  }

  // 🔥 FORMULIR PLACEHOLDER
  Widget _buildPlaceholderForm(String method) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        'Anda memilih pembayaran $method. Tekan "Bayar Sekarang" untuk melanjutkan.',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }

  // 🔥 TOMBOL BAYAR (Mengembalikan nama tab aktif)
  Widget _buildPayNowButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.indigo],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          // 🔥 Mengembalikan nama tab aktif ke CheckoutPage
          Navigator.pop(context, _activeTab);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'Bayar Sekarang',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
