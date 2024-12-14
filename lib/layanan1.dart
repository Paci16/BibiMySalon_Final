import 'package:flutter/material.dart';

void main() {
  runApp(SalonServicePage1());
}

class SalonServicePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Aksi untuk tombol kembali
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // Aksi untuk keranjang belanja
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
                        child: Text(
                          "Gambar Lokasi",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),

                    // Deskripsi tempat
                    Expanded(
                      child: Text(
                        "LAYANAN 2 YAK.",
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
                        _buildServiceButton("Facial", Icons.face, context),
                        _buildServiceButton("Haircut", Icons.cut, context),
                        _buildServiceButton("Massage", Icons.spa, context),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildServiceButton("Nails", Icons.brush, context),
                        _buildServiceButton("Makeup", Icons.brush, context),
                        _buildServiceButton("Waxing", Icons.local_fire_department, context),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Package promo
                Text(
                  "Package Promo",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildPackageButton("Promo 1", context),
                    _buildPackageButton("Promo 2", context),
                    _buildPackageButton("Promo 3", context),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServicePage(serviceName: serviceName)),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(icon, size: 30),
          ),
          SizedBox(height: 10),
          Text(serviceName),
        ],
      ),
    );
  }

  // Fungsi untuk membangun tombol paket promo
  Widget _buildPackageButton(String packageName, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aksi ketika paket promo ditekan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PackagePage(packageName: packageName)),
        );
      },
      child: Container(
        height: 100,
        width: 100,
        color: Colors.pinkAccent,
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

// Halaman layanan
class ServicePage extends StatelessWidget {
  final String serviceName;

  // Memastikan parameter serviceName diterima dengan benar
  ServicePage({required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceName),
        backgroundColor: Colors.pinkAccent,
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
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Text("Detail untuk paket promo $packageName"),
      ),
    );
  }
}