//home.dart

import 'package:flutter/material.dart';
import 'layanan.dart';
import 'login.dart'; // Mengimpor halaman login

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Daftar nama untuk banner dan offer
  final List<Map<String, String>> bannerData = [
    {
      "title": "ByBy My Salon Jakarta",
      "image": "img/salon1.jpeg",
      "description": "Jakarta, DKI Jakarta"
    },
    {
      "title": "ByBy My Salon Bogor",
      "image": "img/salon2.jpeg",
      "description": "Bogor, Jawa Barat"
    },
    {
      "title": "ByBy My Salon Depok",
      "image": "img/salon3.jpeg",
      "description": "Depok, Jawa Barat"
    },
    {
      "title": "ByBy My Salon Tangerang",
      "image": "img/salon4.jpeg",
      "description": "Tangerang, Banten"
    },
    {
      "title": "ByBy My Salon Bekasi",
      "image": "img/salon5.jpeg",
      "description": "Bekasi, Jawa Barat"
    },
  ];

  // Ganti daftar offer menjadi gambar
  final List<String> offerImages = [
    "img/Voucher.jpg",
    "img/Voucher1.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEAE3), // Latar belakang sudah sesuai (tidak diubah)
      appBar: AppBar(
        backgroundColor: const Color(0xFF121481), // Tetap (biru tua)
        toolbarHeight: 80.0, // Sesuaikan tinggi toolbar agar lebih proporsional
        title: Stack(
          children: [
            Center( // Menggunakan Center agar logo benar-benar berada di tengah
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0), // Padding atas dan bawah untuk menyeimbangkan posisi
                child: Image.asset(
                  'img/logo.jpg', // Path ke file logo Anda
                  height: 50, // Ukuran logo yang lebih besar
                ),
              ),
            ),
            Positioned( // Menggunakan Positioned untuk mengontrol posisi tombol Login
              right: 0, // Menjaga tombol di kanan
              top: 20, // Sesuaikan jarak dari atas agar tombol lebih ke bawah
              child: TextButton(
                onPressed: () {
                  // Aksi untuk navigasi ke halaman LoginPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SalonLoginPage(), // Arahkan ke halaman LoginPage
                    ),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Welcome
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(width: 10), // Memberikan jarak antara logo dan teks
                Text(
                  "Welcome, Pretty!",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Section Offers (Horizontal Scrollable)
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: offerImages.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCBCB), // Menggunakan warna baru FFCBCB (merah muda terang)
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Image.asset(
                        offerImages[index], // Menampilkan gambar offer
                        fit: BoxFit.cover, // Mengatur agar gambar menyesuaikan area
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Section Banner (Vertical Scrollable)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: bannerData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (index == 0) { // Jakarta
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SalonServicePage(),
                        ),
                      );
                    } else { // Other cities
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Informasi"),
                            content:
                            Text("Belum Tersedia di Kota Mu"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB1B1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          bannerData[index]['image']!,
                          height: 170,
                          width: 170,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                bannerData[index]['title']!,
                                style:
                                const TextStyle(fontSize: 20, color: Colors.black),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                bannerData[index]['description']!,
                                style:
                                const TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

