import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Warna background abu-abu muda
        fontFamily: 'Sans-Serif', // Sesuaikan dengan font project kamu
      ),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _currentIndex = 2; // Default di halaman 'Akun'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- SECTION PROFIL ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Foto Profil (Menggunakan gambar Colonel Sanders sebagai placeholder lucu dari mockup)
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=200'), // Ganti dengan asset lokal jika ada
                  ),
                  const SizedBox(width: 16),
                  // Nama & Badge
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ahmad Firdausy Ahla',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD2E9FF), // Biru muda badge
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Kanker Bulu Ayam',
                            style: TextStyle(
                              color: Color(0xFF1E88E5),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),

              // --- JUDUL PENGATURAN ---
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Pengaturan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF757575),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // --- MENU PENGATURAN (CARD) ---
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.palette_outlined,
                      title: 'Tampilan',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 60, endIndent: 16, color: Color(0xFFE0E0E0)),
                    _buildMenuItem(
                      icon: Icons.qr_code_scanner_rounded,
                      title: 'ID BPJS',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 60, endIndent: 16, color: Color(0xFFE0E0E0)),
                    _buildMenuItem(
                      icon: Icons.mail_outline_rounded,
                      title: 'Kaitkan Akun',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // --- TOMBOL KELUAR ---
              InkWell(
                onTap: () {
                  // Aksi logout di sini
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5F5), // Background merah sangat muda
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFFD2D2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout_rounded, color: Color(0xFFE53935)),
                      const SizedBox(width: 10),
                      const Text(
                        'Keluar',
                        style: TextStyle(
                          color: Color(0xFFE53935),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 35),

              // --- FOOTER PRIVASI ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(color: Color(0xFF616161), fontSize: 13, height: 1.4),
                    children: [
                      TextSpan(text: 'Privasi, keamanan, dan kenyamanan pengguna adalah '),
                      TextSpan(
                        text: 'prioritas kami.',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // --- BOTTOM NAVIGATION BAR KUSTOM ---
      bottomNavigationBar: Container(
        height: 90,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(0, Icons.home_outlined, 'Beranda'),
            _buildCenterScanningButton(),
            _buildBottomNavItem(2, Icons.person, 'Akun'),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk Item Menu List
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF616161)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF333333),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xFF757575)),
      onTap: onTap,
    );
  }

  // Widget Helper untuk Navigasi Bawah Biasa
  Widget _buildBottomNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
            color: isSelected ? const Color(0xFF333333) : const Color(0xFF9E9E9E),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFF333333) : const Color(0xFF9E9E9E),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk Tombol Scanning Besar di Tengah
  Widget _buildCenterScanningButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, -10), // Membuat tombol agak naik ke atas
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3), // Warna biru cerah scanning
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2196F3).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: const Icon(
              Icons.qr_code_scanner_sharp,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        const Text(
          'Scanning',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF333333),
          ),
        )
      ],
    );
  }
}