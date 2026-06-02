import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/email_edit_page.dart'; // Mengarah ke file dashboard terpisah

// TODO: Jangan lupa import file AuthPage lu biar bisa redirect pas logout
// import 'auth_page.dart';

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({super.key});

  @override
  State<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreen> {
  bool _isLoading = true;
  String _namaUser = "Memuat data...";
  String _noBpjs = "-";

  // Samain Base URL-nya sama yang di AuthPage lu
  final String baseUrl = "https://pelican-reword-affection.ngrok-free.dev";

  @override
  void initState() {
    super.initState();
    _fetchProfilUser();
  }

  // --- FUNGSI AMBIL DATA PROFIL DARI API ---
  Future<void> _fetchProfilUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        // Kalau ga ada token, paksa logout
        _goToLogin();
        return;
      }

      // Pastikan '/api/flutter/user' ini beneran endpoint profil di Laravel lu
      final response = await http.get(
        Uri.parse("$baseUrl/api/flutter/user"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "true", // Wajib ada kalau pake ngrok
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          // Ganti 'name' & 'no_bpjs' sesuai dengan key JSON yang dilempar backend lu
          _namaUser = data['name'] ?? data['username'] ?? 'User Tanpa Nama';
          _noBpjs = data['no_bpjs'] ?? 'Belum ada No. BPJS';
          _isLoading = false;
        });
      } else {
        _showSnackBar("Gagal mengambil data profil.");
        setState(() => _isLoading = false);
      }
    } catch (e) {
      _showSnackBar("Terjadi kesalahan jaringan.");
      setState(() => _isLoading = false);
    }
  }

  // --- FUNGSI LOGOUT ---
  Future<void> _handleLogout() async {
    // Tunjukin loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Hapus token dari HP

    if (!mounted) return;
    Navigator.pop(context); // Tutup loading dialog
    _goToLogin();
  }

  // --- NAVIGASI KEMBALI KE LOGIN ---
  void _goToLogin() {
    // TODO: Buka komen baris di bawah ini kalau file AuthPage udah di-import
    /*
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
      (route) => false, // Hapus semua riwayat halaman (clear stack)
    );
    */
    // SEMENTARA AJA sebelum lu buka komen atas:
    _showSnackBar("Logout berhasil! (Redirect ke AuthPage belum aktif)");
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Kalau lagi loading API, munculin spinner di tengah layar
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),

                      // --- SECTION 1: KARTU PROFIL USER (DINAMIS) ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _namaUser, // <-- Variabel Nama dinamis
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D3142),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Badge Nomor BPJS
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.credit_card_rounded,
                                    size: 16,
                                    color: Color(0xFF1E88E5),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'No. BPJS: $_noBpjs', // <-- Variabel BPJS dinamis
                                    style: const TextStyle(
                                      color: Color(0xFF1E88E5),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // --- SECTION 2: JUDUL PENGATURAN ---
                      const Text(
                        'Pengaturan Akun',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // --- SECTION 3: KOTAK MENU LIST ---
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1.5,
                          ),
                        ),
                        // PERUBAHAN: Keyword 'const' di depan Column dihapus biar Navigator bisa jalan
                        child: Column(
                          children: [
                            MenuTileSetting(
                              icon: Icons.alternate_email_rounded,
                              title: 'Edit Email',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditEmailScreen(), // Sesuai nama class di file tujuan lu
                                  ),
                                );
                              },
                            ),
                            const Divider(
                              height: 1,
                              indent: 20,
                              endIndent: 20,
                              color: Color(0xFFE0E0E0),
                            ),
                            const MenuTileSetting(
                              icon: Icons.lock_outline_rounded,
                              title: 'Edit Password',
                            ),
                            const Divider(
                              height: 1,
                              indent: 20,
                              endIndent: 20,
                              color: Color(0xFFE0E0E0),
                            ),
                            const MenuTileSetting(
                              icon: Icons.phone_android_rounded,
                              title: 'Nomor Telepon',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // --- SECTION 4: TOMBOL KELUAR ---
                      InkWell(
                        onTap: _handleLogout, // <-- Panggil fungsi logout
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.redAccent.shade100,
                              width: 1.5,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                color: Colors.redAccent,
                                size: 22,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Keluar',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // --- SECTION 5: FOOTER PRIVASI ---
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 24.0),
                          child: Text.rich(
                            TextSpan(
                              text:
                                  'Privasi, keamanan, dan kenyamanan pengguna\nadalah ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(
                                  text: 'prioritas kami.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

// --- CUSTOM COMPONENT: BARIS MENU PENGATURAN ---
class MenuTileSetting extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap; // PERUBAHAN 1: Tambah variabel onTap opsional

  const MenuTileSetting({
    super.key,
    required this.icon,
    required this.title,
    this.onTap, // PERUBAHAN 2: Daftarkan di constructor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // PERUBAHAN 3: Masukkan fungsi onTap ke dalam InkWell
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Container Icon Sisi Kiri
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF2D3142), size: 22),
            ),
            const SizedBox(width: 16),
            // Judul Menu
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2D3142),
              ),
            ),
            const Spacer(),
            // Panah Sisi Kanan
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
