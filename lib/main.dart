import 'package:flutter/material.dart';
import 'package:bekantan/pages/home_page.dart'; // Import halaman HomePage
import 'package:bekantan/pages/search_page.dart'; // Import halaman SearchPage
import 'package:bekantan/pages/profile_page.dart'; // Import halaman ProfilePage
import 'package:bekantan/pages/auth/login_page.dart'; // Import halaman LoginPage
import 'package:bekantan/pages/auth/auth_service.dart'; // Import AuthService

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: AuthService().isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasData && snapshot.data == true) {
            return MainPage(); // Halaman utama jika sudah login
          } else {
            return LoginPage(); // Halaman login jika belum login
          }
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/splash.png', // Ganti dengan path gambar Anda
              height: 40, // Sesuaikan ukuran gambar sesuai kebutuhan
            ),
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 8.0), // Atur padding sesuai kebutuhan
            child: IconButton(
              icon: Icon(Icons.notifications),
              color: Colors.black, // Ganti dengan warna yang Anda inginkan
              onPressed: () {
                // Aksi ketika ikon notifikasi ditekan
              },
            ),
          ),
        ],
        elevation: 0, // Hapus elevasi jika tidak diperlukan
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const <Widget>[
          HomePage(), // Halaman Home - Indeks 0
          SearchPage(), // Halaman Search - Indeks 1
          ProfilePage(), // Halaman Profile - Indeks 2
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        iconSize: 24,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }
}
