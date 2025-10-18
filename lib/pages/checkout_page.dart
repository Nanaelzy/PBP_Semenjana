import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../cart_provider.dart';
import 'order_confirmation_page.dart';
import 'payment_selection_modal.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // STATE ALAMAT (Membuat Alamat Dapat Diedit)
  String _addressLabel = '  ';
  String _addressDetail = '  ';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    const double shippingCost = 25000.0;
    final double grandTotal = cart.totalPrice + shippingCost;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Checkout & Pembayaran',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF23A5C2),
        shadowColor: Colors.black.withOpacity(0.05),
        centerTitle: true,
      ),

      // 🔥 PERUBAHAN UTAMA: BODY DIUBAH MENJADI COLUMN DENGAN EXPANDED
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            // Column utama di body
            children: [
              // 1. KONTEN YANG DAPAT DI-SCROLL
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- INFORMASI PENGIRIMAN ---
                      _buildSectionTitle(context, 'Alamat Pengiriman'),
                      _buildAddressCard(),
                      const SizedBox(height: 24),

                      // --- RINCIAN PESANAN (BARANG) ---
                      _buildSectionTitle(
                        context,
                        'Produk Anda (${cart.items.length} item)',
                      ),
                      _buildProductList(cart),
                      const SizedBox(height: 24),

                      // --- RINGKASAN HARGA ---
                      _buildSectionTitle(context, 'Ringkasan Pembayaran'),
                      _buildPriceSummaryCard(
                        context,
                        cart.totalPrice,
                        shippingCost,
                      ),
                      const SizedBox(height: 30), // Padding di atas footer
                    ],
                  ),
                ),
              ),

              // 2. 🔥 FOOTER FINAL CHECKOUT BAR
              // Dipanggil di luar SingleChildScrollView agar tetap terlihat di bawah
              _buildFinalCheckoutBar(context, grandTotal),
            ],
          ),
        ),
      ),
      // 🔥 bottomNavigationBar DIHAPUS (karena sudah dipindah ke body)
    );
  }

  // ---------------- EDIT ADDRESS DIALOG ----------------
  // Fungsi untuk menampilkan dialog edit alamat
  void _editAddress() {
    final labelController = TextEditingController(text: _addressLabel);
    final detailController = TextEditingController(text: _addressDetail);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Alamat Pengiriman'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: labelController,
                  decoration: const InputDecoration(
                    labelText: 'Label & Penerima',
                  ),
                ),
                TextField(
                  controller: detailController,
                  decoration: const InputDecoration(labelText: 'Detail Alamat'),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF23A5C2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Simpan'),
              onPressed: () {
                setState(() {
                  _addressLabel = labelController.text;
                  _addressDetail = detailController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ---------------- SECTION TITLE ----------------
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1B4965),
        ),
      ),
    );
  }

  // ---------------- ADDRESS CARD (Menggunakan State) ----------------
  Widget _buildAddressCard() {
    return Card(
      elevation: 3,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: _editAddress, // Memanggil fungsi edit
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: Colors.redAccent,
                size: 30,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _addressLabel, // Menggunakan state
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _addressDetail, // Menggunakan state
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.grey),
                onPressed: _editAddress, // Memanggil fungsi edit
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- PRODUCT LIST (Sama) ----------------
  Widget _buildProductList(CartProvider cart) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cart.items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = cart.items[index];
          final itemTotal = item.product.price * item.quantity;
          final formattedItemTotal = NumberFormat.currency(
            locale: 'id',
            symbol: 'Rp ',
            decimalDigits: 0,
          ).format(itemTotal);

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item.product.imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              item.product.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '${item.quantity} x ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(item.product.price)}',
              style: const TextStyle(color: Colors.black54),
            ),
            trailing: Text(
              formattedItemTotal,
              style: const TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- PRICE SUMMARY CARD (Sama) ----------------
  Widget _buildPriceSummaryCard(
    BuildContext context,
    double subtotal,
    double shippingCost,
  ) {
    final grandTotal = subtotal + shippingCost;

    return Card(
      elevation: 3,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildPriceRow('Subtotal Barang', subtotal, false),
            const SizedBox(height: 10),
            _buildPriceRow('Biaya Pengiriman', shippingCost, false),
            _buildPriceRow('Diskon Voucher', 0.0, false, discount: true),
            const Divider(height: 25, thickness: 1),
            _buildPriceRow('TOTAL AKHIR', grandTotal, true),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    double amount,
    bool isTotal, {
    bool discount = false,
  }) {
    final formattedAmount = NumberFormat.currency(
      locale: 'id',
      symbol: discount ? '-Rp ' : 'Rp ',
      decimalDigits: 0,
    ).format(amount);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? const Color(0xFF1B4965) : Colors.grey[700],
          ),
        ),
        Text(
          formattedAmount,
          style: TextStyle(
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
            color: isTotal
                ? Colors.deepOrange
                : (discount ? Colors.green : Colors.black87),
          ),
        ),
      ],
    );
  }

  // ---------------- FINAL CHECKOUT BAR (Ditempatkan di Body) ----------------
  Widget _buildFinalCheckoutBar(BuildContext context, double grandTotal) {
    final formattedTotal = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(grandTotal);

    return Container(
      width: double.infinity, // Penting agar meregang di dalam ConstrainedBox
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TOTAL
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Total Akhir',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedTotal,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
            // BUTTON
            ElevatedButton.icon(
              onPressed: () async {
                final String? selectedMethod = await Navigator.push(
                  context,
                  MaterialPageRoute<String>(
                    builder: (context) =>
                        PaymentSelectionModal(amountDue: grandTotal),
                  ),
                );

                if (selectedMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pembayaran dibatalkan.')),
                  );
                  return;
                }

                final cartProvider = Provider.of<CartProvider>(
                  context,
                  listen: false,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Pembayaran via $selectedMethod dikonfirmasi!',
                    ),
                  ),
                );
                cartProvider.clear();

                // Navigasi ke Konfirmasi Sukses
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderConfirmation(),
                  ),
                );
              },
              icon: const Icon(Icons.payment, color: Colors.white),
              label: const Text(
                'Bayar Sekarang',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
