//profilelogin.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'companyprofilelog.dart';
import 'homelog.dart';

class ProfileLogin extends StatefulWidget {
  @override
  _ProfileLoginState createState() => _ProfileLoginState();
}

class _ProfileLoginState extends State<ProfileLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? userProfile;
  int _selectedIndex = 0; // Initialize selected index

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String email = user.email ?? "";
      if (email.isNotEmpty) {
        try {
          QuerySnapshot querySnapshot = await _firestore
              .collection('users')
              .where('email', isEqualTo: email)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            var userDoc = querySnapshot.docs.first.data() as Map<String, dynamic>;
            setState(() {
              userProfile = userDoc;
            });
          } else {
            print('Pengguna tidak ditemukan');
          }
        } catch (error) {
          print('Terjadi kesalahan saat mengambil data: $error');
        }
      } else {
        print('Email pengguna tidak tersedia');
      }
    } else {
      print('Pengguna tidak ditemukan');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Change selected index
    });
    // Navigate to selected page based on index
    if (index == 2) { // Changed from index == 2 to index == 0
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CompanyProfileLog()));
    } else if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLog()));
    } else if (index == 2) { // This was correct
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileLogin()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF121481),
      ),
      body: userProfile == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture can be added here

              // Email Card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: ListTile(
                  leading: Icon(Icons.email, color: Color(0xFF121481)),
                  title: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(userProfile!['email'] ?? 'Tidak ada email'),
                ),
              ),
              SizedBox(height: 20),

              // Username Card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: ListTile(
                  leading: Icon(Icons.person, color: Color(0xFF121481)),
                  title: Text('Username', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(userProfile!['username'] ?? 'Tidak ada username'),
                ),
              ),
              SizedBox(height: 20),

              // Telephone Card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: ListTile(
                  leading: Icon(Icons.phone, color: Color(0xFF121481)),
                  title: Text('Telepon', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(userProfile!['telephone'] ?? 'Tidak ada telepon'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "Company"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}