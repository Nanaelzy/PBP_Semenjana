import 'package:flutter/material.dart';
import 'model/product.dart';
import 'services/product_service.dart';
import 'detail_page.dart';

class ProductListPage extends StatefulWidget {
  final String initialFilter;
  const ProductListPage({super.key, this.initialFilter = 'all'});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  String selectedFilter = 'all';
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProducts();
    searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _filterByAll(widget.initialFilter);
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void loadProducts() {
    setState(() {
      allProducts = ProductService.getAllProducts();
      filteredProducts = allProducts;
    });
  }

  void _onSearchChanged() {
    String query = searchController.text;
    setState(() {
      if (query.isEmpty) {
        _filterByAll(selectedFilter);
      } else {
        filteredProducts = ProductService.searchProducts(query);
      }
    });
  }

  void _filterByAll(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == 'all') {
        filteredProducts = allProducts;
      } else if (filter == 'shirt') {
        filteredProducts = allProducts.where((p) => p is Shirt).toList();
      } else if (filter == 'tie') {
        filteredProducts = allProducts
            .where((p) => p is Accessory && p.type == 'Tie')
            .toList();
      } else if (filter == 'purse') {
        filteredProducts = allProducts
            .where((p) => p is Accessory && p.type == 'Purse')
            .toList();
      }
      if (searchController.text.isNotEmpty) {
        filteredProducts = filteredProducts
            .where(
              (item) => item.name.toLowerCase().contains(
                searchController.text.toLowerCase(),
              ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Semenjana Handmade Shop',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 35, 165, 194),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFEDA2), Color(0xFF4282AA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Cari produk handmade...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildFilterButton('all', 'Semua'),
                  _buildFilterButton('shirt', 'Kemeja'),
                  _buildFilterButton('tie', 'Dasi'),
                  _buildFilterButton('purse', 'Dompet'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak ada produk ditemukan',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return _buildProductItem(product);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String value, String label) {
    bool isSelected = selectedFilter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) => _filterByAll(value),
        backgroundColor: Colors.white,
        selectedColor: const Color.fromARGB(255, 35, 165, 194).withOpacity(0.2),
        labelStyle: TextStyle(
          color: isSelected
              ? const Color.fromARGB(255, 35, 165, 194)
              : Colors.black54,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        side: BorderSide(
          color: isSelected ? const Color(0xFF4282AA) : Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        // Atur bayangan di Container
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 0.0,
        color: Colors.white.withOpacity(0.6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      product.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.shopping_bag,
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.formattedPrice,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
