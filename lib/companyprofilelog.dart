import 'package:flutter/material.dart';
import 'homelog.dart'; // Import HomeLog page
import 'profileLogin.dart'; // Import Profile page

class CompanyProfileLog extends StatefulWidget {
  const CompanyProfileLog({super.key});

  @override
  State<CompanyProfileLog> createState() => _CompanyProfileStateLog();
}

class _CompanyProfileStateLog extends State<CompanyProfileLog> {
  int _selectedIndex = 0; // Initialize selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Change selected index
    });
    // Navigate to selected page based on index
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CompanyProfileLog()));
    } else if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLog()));
    } else if (index == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileLogin()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Company Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF121481), // Dark blue color
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('img/BiBiMyCompany.png'), // Local image
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(height: 16),
          SectionTitle(title: 'Informasi Perusahaan'),
          InfoCard(
            title: 'Tentang Kami',
            description:
            'BiBiMy adalah salon kecantikan yang berkomitmen untuk memberikan layanan terbaik bagi pelanggan. Kami menawarkan berbagai layanan yang pastinya sangat beragam dan akan membuat anda percaya dengan diri anda.',
          ),
          InfoCard(
            title: 'Visi dan Misi',
            description:
            'Visi kami adalah memberdayakan setiap individu untuk merasa percaya diri dan unik.\nMisi kami adalah memberikan ruang yang aman dan ramah di mana setiap orang dapat mengekspresikan kecantikan dan jati diri setiap pelanggan.',
          ),
          SectionTitle(title: 'Kontak Kami'),
          InfoCard(
            title: 'Alamat',
            description: 'Jl. Bersamamu, Paris, Australia',
          ),
          InfoCard(
            title: 'Telepon',
            description: '+62 123 456 789',
          ),
          InfoCard(
            title: 'Email',
            description: 'bibimysalon@bibimy.com',
          ),
          SectionTitle(title: 'Media Sosial'),
          SocialMediaCard(
            platform: 'Instagram',
            url: 'https://www.instagram.com/bibimy',
          ),
          SocialMediaCard(
            platform: 'Facebook',
            url: 'https://www.facebook.com/bibimy',
          ),
          SocialMediaCard(
            platform: 'Twitter',
            url: 'https://www.twitter.com/bibimy',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Menambahkan properti ini
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

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF121481), // Dark blue for text
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String description;

  const InfoCard({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFCBCB), // Light background for the card
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF121481), // Dark blue for titles
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(color: Colors.black), // Default text color
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaCard extends StatelessWidget {
  final String platform;
  final String url;

  const SocialMediaCard({Key? key, required this.platform, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFCBCB),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          platform,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF121481), // Dark blue for platform text
          ),
        ),
        trailing:
        Icon(Icons.arrow_forward, color: Color(0xFF121481)),
        // Dark blue for the arrow icon
        onTap:
            () =>
            _showSocialMediaDialog(
                context, platform, url), // Call dialog function
      ),
    );
  }

  void _showSocialMediaDialog(BuildContext context, String platform,
      String url) {
    showDialog(
        context:
        context,
        builder:
            (context) =>
            AlertDialog(
              title:
              Text('Media Sosial'),
              content:
              Text('Kunjungi $platform di:\n$url'),
              actions:
              [
                TextButton(onPressed:
                    () => Navigator.pop(context), child:
                Text('Tutup')),
              ],
            ));
  }
}