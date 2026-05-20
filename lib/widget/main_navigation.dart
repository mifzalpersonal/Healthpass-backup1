import 'package:flutter/material.dart';
import '../pages/home_page.dart';
// import '../pages/scan_page.dart';       // Un-comment jika file sudah ada
// import '../pages/settings_page.dart';   // Un-comment jika file sudah ada

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // List halaman setelah login
  final List<Widget> _pages = [
    const HomePage(),
    
    // Ganti Placeholder di bawah ini dengan file ScanPage & SettingsPage kamu jika sudah dibuat
    const Center(child: Text('Halaman Scan QR', style: TextStyle(fontSize: 20))), 
    const Center(child: Text('Halaman Pengaturan / Akun', style: TextStyle(fontSize: 20))), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menampilkan halaman aktif berdasarkan indeks navbar
      body: _pages[_currentIndex],
      
      // 1. Tombol Tengah (Scanning)
      floatingActionButton: SizedBox(
        width: 72,
        height: 72,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _currentIndex = 1; // Pindah ke ScanPage
            });
          },
          backgroundColor: const Color(0xFF3299FF),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(
            Icons.qr_code_scanner_rounded, 
            color: Colors.white, 
            size: 36,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 2. Bar Navigasi (Beranda & Akun/Settings)
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.4),
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Tombol Beranda (Kiri)
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = 0; // Pindah ke HomePage
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home_rounded,
                        color: _currentIndex == 0 ? const Color(0xFF424242) : Colors.grey,
                        size: 28,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Beranda',
                        style: TextStyle(
                          color: _currentIndex == 0 ? const Color(0xFF424242) : Colors.grey,
                          fontSize: 12,
                          fontWeight: _currentIndex == 0 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Spacer untuk ruang FloatingActionButton di tengah
              const SizedBox(width: 72),

              // Tombol Akun / Settings (Kanan)
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = 2; // Pindah ke SettingsPage
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: _currentIndex == 2 ? const Color(0xFF424242) : Colors.grey,
                        size: 28,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Akun',
                        style: TextStyle(
                          color: _currentIndex == 2 ? const Color(0xFF424242) : Colors.grey,
                          fontSize: 12,
                          fontWeight: _currentIndex == 2 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}