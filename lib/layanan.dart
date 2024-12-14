import 'package:flutter/material.dart';
import 'cart.dart';  // Mengimpor halaman Cart
import 'NailArtPage.dart';  // Mengimpor halaman NailArtPage
import 'MakeUp.dart';  // Mengimpor halaman MakeUpPage
import 'haircut.dart';
import 'body_spa_page.dart';
import 'coloring.dart';
import 'creambath.dart';
import 'premiumbun.dart';
import 'diamondbun.dart';
import 'bronzebun.dart';



void main() {
  runApp(SalonServicePage());
}

class SalonServicePage extends StatefulWidget {
  @override
  _SalonServicePageState createState() => _SalonServicePageState();
}

class _SalonServicePageState extends State<SalonServicePage> {
  List<Map<String, String>> cartItems = []; // Cart items state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFB1B1), // Updated AppBar color
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // Navigasi ke halaman Cart saat ikon keranjang ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(items: cartItems),  // Arahkan ke halaman Cart
                  ),
                ).then((result) {
                  // Update cart items if any changes occur on returning from Cart
                  if (result != null && result is List<Map<String, String>>) {
                    setState(() {
                      cartItems = result; // Update cart items
                    });
                  }
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Gambar dan deskripsi sejajar (dalam Row)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar lokasi
                    Container(
                      height: 150,
                      width: 150,
                      color: Colors.grey,
                      child: Center(
                        child: Image.asset('img/salon1.jpeg'),
                      ),
                    ),
                    SizedBox(width: 20),
                    // Deskripsi tempat
                    Expanded(
                      child: Text(
                        "Salon Bibimy adalah tempat terbaik untuk perawatan kecantikan dan rambut. Kami menyediakan layanan profesional dengan berbagai perawatan terbaru untuk membuat Anda merasa lebih cantik dan percaya diri.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Layanan bulat (6 layanan dalam 2 baris)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildServiceButton("Creambath", Icons.face, context),
                        _buildServiceButton("Hair Cut", Icons.cut, context),
                        _buildServiceButton("Body Spa", Icons.spa, context),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildServiceButton("Nails", Icons.brush, context),
                        _buildServiceButton("Makeup", Icons.palette, context),
                        _buildServiceButton("Coloring", Icons.local_fire_department, context),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Package promo
                Text(
                  "Bundling Package",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPromoColumnButton('img/gold.png', 'Premium Bundling'),
                        _buildPromoColumnButton('img/silver.png', 'Diamond Bundling'),
                        _buildPromoColumnButton('img/bronze.png', 'Bronze Bundling'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun tombol layanan
  Widget _buildServiceButton(String serviceName, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aksi ketika layanan ditekan
        if (serviceName == "Nails") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NailArtPage(onAddToCart: (item) {
              setState(() {
                cartItems.add(item); // Add item to cart
              });
            })),
          );
        } else if (serviceName == "Makeup") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MakeupPage(onAddToCart: (item) {
              setState(() {
                cartItems.add(item); // Add item to cart
              });
            })),
          );
        } else if (serviceName == "Body Spa") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BodySpaPage(onAddToCart: (item) {
              setState(() {
                cartItems.add(item); // Add item to cart
              });
            })),
          );
        } else if (serviceName == "Hair Cut") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HaircutPage(onAddToCart: (item) {
              setState(() {
                cartItems.add(item); // Add item to cart
              });
            })),
          );
        } else if (serviceName == "Creambath") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreambathPage(onAddToCart: (item) {
              setState(() {
                cartItems.add(item); // Add item to cart
              });
            })),
          );
        } else if (serviceName == "Coloring") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ColoringPage(onAddToCart: (item) {
              setState(() {
                cartItems.add(item); // Add item to cart
              });
            })),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ServicePage(serviceName: serviceName)),
          );
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(icon, size: 30),
            backgroundColor: Color(0xFFFFB1B1), // Updated service button background color
          ),
          SizedBox(height: 10),
          Text(serviceName),
        ],
      ),
    );
  }

  // Fungsi untuk membangun gambar promo dan teks
  // Fungsi untuk membangun gambar promo dan teks
  Widget _buildPromoColumnButton(String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        // Navigasi berdasarkan label
        if (label == 'Premium Bundling') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PremiumPage(onAddToCart: (item) {
              setState(() {
                cartItems.add(item); // Menambahkan item ke keranjang
              });
            })),
          );
        } else if (label == 'Diamond Bundling') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiamondPage(onAddToCart: (item) {
              setState(() {
                cartItems.add(item); // Menambahkan item ke keranjang
              });
            })),
          );
        } else if (label == 'Bronze Bundling') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BronzePage(onAddToCart: (item) {
              setState(() {
                cartItems.add(item); // Menambahkan item ke keranjang
              });
            })),
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun tombol paket promo
  Widget _buildPackageButton(String packageName, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PackagePage(packageName: packageName)),
        );
      },
      child: Container(
        height: 100,
        width: 100,
        color: Color(0xFFFFCBCB), // Updated package button background color
        child: Center(
          child: Text(
            packageName,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// Halaman layanan umum
class ServicePage extends StatelessWidget {
  final String serviceName;

  ServicePage({required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceName),
        backgroundColor: Color(0xFFFFEAE3), // Updated AppBar color
      ),
      body: Center(
        child: Text("Detail untuk layanan $serviceName"),
      ),
    );
  }
}

// Halaman paket promo
class PackagePage extends StatelessWidget {
  final String packageName;

  PackagePage({required this.packageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(packageName),
        backgroundColor: Color(0xFFFFEAE3), // Updated AppBar color
      ),
      body: Center(
        child: Text("Detail untuk paket promo $packageName"),
      ),
    );
  }
}
