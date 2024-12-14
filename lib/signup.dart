import 'dart:developer';

import 'package:bibimysalon_klmpk6/auth_service.dart';
import 'package:bibimysalon_klmpk6/database_service.dart';
import 'package:bibimysalon_klmpk6/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homelog.dart'; // Pastikan mengimpor halaman HomeLogPage

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //ini ke database
  final _dbService = DatabaseService();

  //ini bagian autentifikasi
  final _auth = AuthService();

//bagian control firebass
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _telephone = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _email.dispose();
    _telephone.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEAE3), // Background color
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container untuk memberikan jeda di atas logo
            Container(
              height: 80, // Atur tinggi sesuai kebutuhan
              color: Color(0xFF121481), // Warna jeda
            ),

            // Logo Container with Bottom Color
            Container(
              color: Color(0xFF121481), // Warna di bawah logo
              child: Column(
                children: [
                  Image.asset(
                    "img/logo.jpg", // Pastikan logo Anda sudah ada di folder assets
                    height: 120,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),

            // Garis
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              padding: EdgeInsets.only(top: 30),
              child: Divider(
                color: Color(0xFFFFB1B1), // Menggunakan warna dari palet
                thickness: 5,
              ),
            ),
            SizedBox(height: 20),

            // Judul Sign Up
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF121481), // Menggunakan warna dari palet
              ),
            ),
            SizedBox(height: 20),

            // Input Email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                //bagian control firebass
                controller: _email,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFFFB1B1)), // Border color when focused
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Input Nomor HP
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                //bagian control firebass
                controller: _telephone,
                decoration: InputDecoration(
                  labelText: "Nomor HP",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFFFB1B1)), // Border color when focused
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Input Username
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                //bagian control firebass
                controller: _username,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFFFB1B1)), // Border color when focused
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Input Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                //bagian control firebass
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFFFB1B1)), // Border color when focused
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),

            // Button Sign Up
            ElevatedButton(
              onPressed: () async {

                //bagian Auth
                _signup();

                //untuk ambil text dari field yang ada di tampilan
                final user = User(
                    email: _email.text,
                    telephone: _telephone.text,
                    username: _username.text,
                    password: _password.text);
                _dbService.create(user);

                // Aksi ketika tombol Sign Up ditekan
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeLog()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                Color(0xFFFFB1B1), // Menggunakan warna dari palet
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.white), // Text color for button
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  _signup()async{
    await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
  }

}

//untuk memasukkan data sign up ke database firebase
class User {
  final String email;
  final String telephone;
  final String username;
  final String password;

  User(
      {required this.email,
        required this.telephone,
        required this.username,
        required this.password});
}


