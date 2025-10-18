import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';
import '../cart_provider.dart';
// Asumsi model/product.dart menyediakan Product, Shirt, dan Accessory
import '../model/product.dart';

// Warna Dasar Modern
const Color _primaryColor = Color.fromARGB(255, 35, 165, 194);
const Color _cardColor = Colors.white;

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  // Helper untuk memformat harga (Sama seperti kode aslimu)
  String get formattedPrice =>
      'Rp ${product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

  // Helper untuk baris info (Sama seperti kode aslimu)
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54, // Label lebih redup
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ⭐️ Struktur utama di-Center dan dibatasi lebarnya untuk web
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.white,
        foregroundColor: _primaryColor,
        elevation: 2,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFEDA2), Color(0xFF4282AA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ), // Batasi lebar total konten di tengah
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductImageSection(context),
                  const SizedBox(height: 30),

                  _buildProductDetailsCard(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(context),
    );
  }

  Widget _buildProductImageSection(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 450, maxHeight: 450),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _cardColor, // Latar belakang putih
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              product.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.shopping_bag, size: 150, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetailsCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.white, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedPrice,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.deepOrange.shade800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 30),

            // Info Detail Utama
            _buildInfoRow('Kategori', product.category),
            _buildInfoRow('Stok', '${product.stock} unit'),

            // Info Detail Turunan (Shirt/Accessory)
            if (product is Shirt) ...[
              const Divider(height: 10),
              _buildInfoRow('Ukuran', (product as Shirt).size),
              _buildInfoRow('Bahan', (product as Shirt).material),
            ],
            if (product is Accessory) ...[
              const Divider(height: 10),
              _buildInfoRow('Tipe', (product as Accessory).type),
            ],
            const Divider(height: 30),

            // Deskripsi
            const Text(
              'Deskripsi Produk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk Bottom Button (Fungsi sama)
  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: GFButton(
          onPressed: () {
            // FUNGSI INTI (Tidak Berubah)
            Provider.of<CartProvider>(context, listen: false).add(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} berhasil ditambahkan!'),
                duration: const Duration(milliseconds: 1500),
              ),
            );
          },
          text: 'Tambah ke Keranjang',
          icon: const Icon(
            Icons.add_shopping_cart,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          size: GFSize.LARGE,
          color: Color.fromARGB(255, 54, 164, 232),
          shape: GFButtonShape.pills,
          fullWidthButton: true,
          textStyle: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 249, 249, 249),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
