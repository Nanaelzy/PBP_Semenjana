import 'product.dart';

class ProductService {
  static List<Product> getAllProducts() {
    return [
      Shirt(
        id: 1,
        name: 'Lucky Fish Shirt',
        price: 500000,
        imagePath: 'assets/images/luckyfish.jpg',
        description:
            'Kemeja ini menggabungkan gaya kasual dengan sentuhan keberuntungan. Dengan motif ikan yang unik, setiap kemeja melambangkan keberuntungan dan kelimpahan. Terbuat dari bahan yang nyaman dan ringan, kemeja ini ideal untuk tampilan sehari-hari yang santai namun tetap memiliki makna.',
        stock: 25,
        size: 'M',
        material: 'Katun',
      ),
      Shirt(
        id: 2,
        name: 'Sakura Frisky Shirt',
        price: 500000,
        imagePath: 'assets/images/sakurafrisky.jpg',
        description:
            'Kemeja ini menghadirkan perpaduan unik antara keindahan bunga sakura dengan sentuhan desain yang ceria dan energik. Terbuat dari bahan yang sejuk dan nyaman, kemeja ini ideal untuk cuaca tropis. Motif bunga sakura yang berwarna-warni memberikan kesan fresh, sementara detail kecil yang dibuat tangan menambah kesan unik dan istimewa.',
        stock: 25,
        size: 'M',
        material: 'Katun',
      ),
      Shirt(
        id: 3,
        name: 'Whale Shark Shirt',
        price: 500000,
        imagePath: 'assets/images/whalesharkshirt.jpg',
        description:
            'Kemeja ini terinspirasi dari hiu paus, dibuat dari katun ringan yang nyaman. Pola hiu paus yang dilukis tangan menjadikan setiap kemeja unik. Pakaian ini cocok untuk penggemar alam dan mereka yang mencari gaya kasual dengan sentuhan unik.',
        stock: 25,
        size: 'M',
        material: 'Katun',
      ),
      Shirt(
        id: 4,
        name: 'Apple Picnic Shirt',
        price: 650000,
        imagePath: 'assets/images/applepicnicshirt.jpg',
        description:
            'Kemeja ini menghadirkan suasana piknik yang ceria. Dengan motif apel yang cerah dan berwarna-warni, kemeja ini terbuat dari bahan katun yang ringan dan nyaman. Desainnya yang santai sangat cocok untuk acara di luar ruangan atau aktivitas sehari-hari yang penuh keceriaan.',
        stock: 15,
        size: 'L',
        material: 'Linen',
      ),
      Shirt(
        id: 5,
        name: 'Doodle Fish Shirt',
        price: 650000,
        imagePath: 'assets/images/doodlefishshirt.jpg',
        description:
            'Kemeja ini menawarkan desain unik yang penuh dengan karakter dan kreativitas. Dengan motif ikan yang digambar tangan (doodle) secara bebas, kemeja ini memiliki kesan artistik, santai, dan ceria. Bahan yang ringan dan nyaman menjadikannya pilihan sempurna untuk mengekspresikan diri dan menambahkan sentuhan menyenangkan pada gaya sehari-hari.',
        stock: 15,
        size: 'L',
        material: 'Linen',
      ),
      Shirt(
        id: 6,
        name: 'Great White Shark Shirt',
        price: 650000,
        imagePath: 'assets/images/greatwhitesharkshirt.jpg',
        description:
            'Kemeja ini menangkap kekuatan dan keanggunan hiu putih besar (great white shark). Terbuat dari bahan yang kuat namun tetap ringan, desain ini menampilkan siluet hiu yang berani dan minimalis. Cocok untuk mereka yang menyukai gaya yang berani, penuh percaya diri, dan menarik perhatian.',
        stock: 15,
        size: 'L',
        material: 'Linen',
      ),
      Accessory(
        id: 7,
        name: 'Spring Breakfast Tie',
        price: 300000,
        imagePath: 'assets/images/springbreakfasttie.jpg',
        description:
            'Dasi ini menghadirkan suasana ceria dan penuh semangat layaknya sarapan di musim semi. Dengan motif makanan sarapan yang imut dan warna-warni, dasi ini terbuat dari bahan lembut dan ringan. Cocok untuk menambahkan sentuhan unik dan ceria pada penampilan formal maupun kasual Anda',
        stock: 50,
        type: 'Tie',
      ),
      Accessory(
        id: 8,
        name: 'Moss Sea Bunny Tie',
        price: 300000,
        imagePath: 'assets/images/mossseabunnytie.jpg',
        description:
            'Dasi ini terbuat dari bahan premium yang lembut. Pola kelinci yang dijahit tangan dengan detail, memberikan sentuhan artistik yang unik. Aksesori ini sempurna untuk gaya yang ingin tampil beda dan berkarakter, cocok untuk acara formal maupun santai.',
        stock: 50,
        type: 'Tie',
      ),
      Accessory(
        id: 9,
        name: 'Starry Kitten Tie',
        price: 300000,
        imagePath: 'assets/images/starrykittentie.jpg',
        description:
            'Dasi ini memadukan tema kosmik dan sentuhan lucu. Terbuat dari bahan yang halus, dasi ini menampilkan pola anak kucing yang bermain di antara bintang-bintang. Desain yang unik ini cocok untuk mereka yang ingin menambahkan sentuhan imajinatif dan playful pada penampilan formal atau semi-formal.',
        stock: 50,
        type: 'Tie',
      ),
      Accessory(
        id: 10,
        name: 'Celestial Owl Purse',
        price: 400000,
        imagePath: 'assets/images/celestialowlpurse.jpg',
        description:
            'Dompet ini didesain dengan tema langit malam yang memukau. Dengan motif burung hantu yang digambar di tengah-tengah rasi bintang, dompet ini memberikan kesan misterius dan elegan. Terbuat dari bahan yang kokoh dan tahan lama, dompet ini memiliki kompartemen fungsional. Dompet ini sangat cocok untuk melengkapi penampilan yang unik dan imajinatif.',
        stock: 30,
        type: 'Purse',
      ),
      Accessory(
        id: 11,
        name: 'Sweetie Bear Purse',
        price: 400000,
        imagePath: 'assets/images/sweetiebearpurse.jpg',
        description:
            'Dompet ini dirancang dengan tampilan yang manis dan menggemaskan. Dengan motif beruang yang lucu, dompet ini memberikan sentuhan imut pada gaya Anda. Terbuat dari bahan yang lembut namun kokoh, dompet ini fungsional untuk menyimpan kartu dan uang tunai. Cocok untuk Anda yang ingin menambahkan aksen ceria dan manis pada penampilan sehari-hari.',
        stock: 20,
        type: 'Purse',
      ),
      Accessory(
        id: 12,
        name: 'Guardian Heart Purse',
        price: 400000,
        imagePath: 'assets/images/guardianheartpurse.jpg',
        description:
            'Dompet ini didesain dengan sentuhan manis dan penuh makna. Dengan motif hati yang melambangkan perlindungan, dompet ini memberikan kesan hangat. Terbuat dari bahan yang kuat dan tahan lama, dompet ini memiliki kompartemen yang fungsional untuk menyimpan barang-barang penting Anda. Aksesori ini sempurna bagi Anda yang ingin memadukan gaya manis dan simbolisme.',
        stock: 30,
        type: 'Purse',
      ),
    ];
  }

  static List<Product> getProductsByCategory(String category) {
    return getAllProducts()
        .where((product) => product.category == category)
        .toList();
  }

  static List<Product> getProductsByType(String type) {
    return getAllProducts().where((product) {
      if (product is Accessory) {
        return product.type == type;
      }
      return false;
    }).toList();
  }

  static List<Product> searchProducts(String query) {
    return getAllProducts()
        .where(
          (product) => product.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
