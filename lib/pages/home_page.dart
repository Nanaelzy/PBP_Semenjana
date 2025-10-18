import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/device_info_service.dart';
import '../cart_provider.dart';
import 'product_list.dart';
import 'login_page.dart';
import '../services/product_service.dart';
import 'detail_page.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  final String userEmail;
  const HomePage({super.key, required this.userEmail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DeviceInfoService _deviceInfoService = DeviceInfoService();
  Map<String, dynamic> _deviceData = {'model': 'Memuat...', 'platform': '...'};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  void _loadDeviceInfo() async {
    try {
      final data = await _deviceInfoService.getDeviceInfo();
      // widget.userEmail digunakan untuk mengakses properti dari HomePage (StatefulWidget)
      print('✅ Device Info for User ${widget.userEmail} loaded: $data');
      setState(() {
        _deviceData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _deviceData = {'model': 'Gagal memuat', 'platform': 'Error'};
        _isLoading = false;
        print('❌ Error memuat info perangkat: $e');
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 35, 165, 194),
          ),
          onPressed: () {
            // Aksi ini membuat Anda kembali ke LoginPage (sesi masih tersimpan!)
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Selamat Datang',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 35, 165, 194),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 2,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) => Badge(
              label: Text(cart.itemCount.toString()),
              isLabelVisible: cart.itemCount > 0,
              backgroundColor: Colors.amber,
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(255, 35, 165, 194),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
              ),
            ),
          ),

          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Color.fromARGB(255, 35, 165, 194),
            ),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 214, 237, 255),
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Selamat Datang
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Device: ${_isLoading ? 'Memuat...' : _deviceData['model']} (${_deviceData['platform']})',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 35, 165, 194),
                        ),
                      ),
                    ),
                    Text(
                      'Halo, ${widget.userEmail.split('@').first}!',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 35, 165, 194),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Temukan produk handmade favoritmu.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 35, 165, 194),
                      ),
                    ),
                  ],
                ),
              ),

              // Bagian Kategori
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jelajahi Kategori',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 35, 165, 194),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCategoryButton(
                          context,
                          'Kemeja',
                          Icons.checkroom,
                        ),
                        _buildCategoryButton(
                          context,
                          'Dasi',
                          Icons.card_giftcard,
                        ),
                        _buildCategoryButton(context, 'Dompet', Icons.wallet),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Produk Unggulan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 35, 165, 194),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFeaturedProducts(context),

                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductListPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            254,
                            255,
                            255,
                          ),
                          foregroundColor: const Color.fromARGB(
                            255,
                            38,
                            121,
                            177,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Lihat Semua Produk',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('registeredEmail');
                await prefs.remove('registeredPassword');
                await prefs.setBool('isLoggedIn', false);

                // Tutup dialog
                Navigator.of(context).pop();
                // Kembali ke halaman login

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  // SINI: Tempatkan kode ini di dalam class HomePage
  Widget _buildFeaturedProducts(BuildContext context) {
    final allProducts = ProductService.getAllProducts();
    final featuredProducts = allProducts
        .take(2)
        .toList(); // Ambil 2 produk pertama

    return Column(
      children: featuredProducts.map((product) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Image.asset(
              product.imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Text(product.formattedPrice),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 35, 165, 194),
            ),
            onTap: () {
              // SINI: Navigasi ke halaman detail produk
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    String filterValue;
    if (title == 'Kemeja') {
      filterValue = 'shirt';
    } else if (title == 'Dasi') {
      filterValue = 'tie';
    } else if (title == 'Dompet') {
      filterValue = 'purse';
    } else {
      filterValue = 'all';
    }

    return Column(
      children: [
        InkWell(
          onTap: () {
            // Implementasi navigasi ke halaman ProductListPage dengan filter kategori
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductListPage(initialFilter: filterValue),
              ),
            );
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: const Color.fromARGB(255, 254, 255, 255),
            child: Icon(
              icon,
              size: 30,
              color: const Color.fromARGB(255, 35, 165, 194),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
