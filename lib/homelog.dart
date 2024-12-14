//homelog.dart
import 'package:bibimysalon_klmpk6/profilelogin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'companyprofilelog.dart'; // Import CompanyProfile page
import 'layanan.dart';


class HomeLog extends StatefulWidget {
  const HomeLog({super.key});

  @override
  State<HomeLog> createState() => _HomeLogState();
}

class _HomeLogState extends State<HomeLog> {
  int _selectedIndex = 1; // Initial index for HomeLog
  String username = ""; // Variable to hold the username
  bool isLoading = true; // Loading state

  void _fetchUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser; // Ensure FirebaseAuth instance is used
    if (user != null) {
      String email = user.email ?? "";
      if (email.isNotEmpty) {
        try {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            var userDoc = querySnapshot.docs.first.data() as Map<String, dynamic>;
            setState(() {
              username = userDoc['username']; // Assuming 'username' is the field name in Firestore
              isLoading = false; // Set loading to false after fetching data
            });
          } else {
            print('User not found');
          }
        } catch (error) {
          print('Error fetching data: $error');
        }
      } else {
        print('User not found');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(); // Call function to fetch username
  }

  final List<Map<String, String>> bannerData = [
    {"title": "ByBy My Salon Jakarta", "image": "img/salon1.jpeg", "description": "Jakarta, DKI Jakarta"},
    {"title": "ByBy My Salon Bogor", "image": "img/salon2.jpeg", "description": "Bogor, Jawa Barat"},
    {"title": "ByBy My Salon Depok", "image": "img/salon3.jpeg", "description": "Depok, Jawa Barat"},
    {"title": "ByBy My Salon Tangerang", "image": "img/salon4.jpeg", "description": "Tangerang, Banten"},
    {"title": "ByBy My Salon Bekasi", "image": "img/salon5.jpeg", "description": "Bekasi, Jawa Barat"},
  ];

  final List<String> offerImages = [
    "img/Voucher.jpg",
    "img/Voucher1.jpg",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Change selected index
      // Navigate to selected page
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyProfileLog()));
      } else if (index == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileLogin()));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEAE3), // Background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF121481), // Dark blue color
        toolbarHeight: 80.0,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image.asset(
              'img/logo.jpg', // Path to your logo image
              height: 50,
            ),
          ),
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
              children: [
                const SizedBox(width: 10),
                isLoading
                    ? CircularProgressIndicator() // Show loading indicator while fetching data
                    : Text(
                  "Welcome, $username!", // Displaying the fetched username
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                      color: const Color(0xFFFFCBCB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Image.asset(
                        offerImages[index],
                        fit: BoxFit.cover,
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
                    if (index == 0) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SalonServicePage()));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Informasi"),
                            content: Text("Belum Tersedia di Kota Mu"),
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
                          child:
                          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children:[
                            Text(bannerData[index]['title']!, style:
                            const TextStyle(fontSize:
                            20, color:
                            Colors.black),),
                            const SizedBox(height:
                            5),
                            Text(bannerData[index]['description']!, style:
                            const TextStyle(fontSize:
                            14, color:
                            Colors.black),),
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
      bottomNavigationBar:
      BottomNavigationBar(
        type:
        BottomNavigationBarType.fixed,
        items:
        const [
          BottomNavigationBarItem(icon:
          Icon(Icons.business), label:
          "Company"),
          BottomNavigationBarItem(icon:
          Icon(Icons.home), label:
          "Home"),
          BottomNavigationBarItem(icon:
          Icon(Icons.person), label:
          "Profile"),
        ],
        currentIndex:
        _selectedIndex,
        onTap:
        _onItemTapped,
      ),
    );
  }
}

