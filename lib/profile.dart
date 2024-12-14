import 'package:flutter/material.dart';
import 'homelog.dart';
import 'login.dart';
import 'signup.dart';

// Halaman Profile dengan informasi pengguna
class Profile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00148D), // Warna biru tua yang konsisten
        toolbarHeight: 80.0,
        title: Stack(
          children: [
            Center( // Menempatkan logo di tengah
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Image.asset(
                  'img/logo.jpg', // Path ke logo
                  height: 50, // Sesuaikan ukuran logo
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tombol Log In
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SalonLoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Warna tombol Log in
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 24, // Ukuran font lebih besar
                    fontWeight: FontWeight.bold, // Tebal
                    color: Colors.white, // Warna teks putih
                  ),
                  textAlign: TextAlign.center, // Posisi teks di tengah
                ),
              ),

              const SizedBox(height: 20), // Jarak antar elemen

              // Tombol Sign Up
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna tombol Sign Up
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24, // Ukuran font lebih besar
                    fontWeight: FontWeight.bold, // Tebal
                    color: Colors.white, // Warna teks putih
                  ),
                  textAlign: TextAlign.center, // Posisi teks di tengah
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}