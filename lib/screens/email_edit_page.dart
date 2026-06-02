import 'package:flutter/material.dart';
import '../screens/email_edit_page.dart'; // Mengarah ke file dashboard terpisah

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditEmailScreen(),
    );
  }
}

class EditEmailScreen extends StatefulWidget {
  const EditEmailScreen({super.key});

  @override
  State<EditEmailScreen> createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen> {
  // Controller untuk mengisi nilai default email
  final TextEditingController _emailController = TextEditingController(
    text: "ahmad.firdausy@gmail.com",
  );

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Warna biru kustom menyesuaikan desain sebelumnya
    const Color primaryBlue = Color(0xFF409CFF);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4), // Background abu-abu terang
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Tombol Back (Kiri Atas)
                Container(
                  decoration: const BoxDecoration(
                    color: primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      // Fungsi kembali ke halaman sebelumnya
                      Navigator.pop(context);
                    },
                  ),
                ),

                const SizedBox(height: 40),

                // 2. Judul Halaman / Label
                const Text(
                  "Ubah Alamat Email",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Pastikan Anda menggunakan alamat email (Gmail) yang aktif untuk menerima informasi terbaru.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

                // 3. Form Input Email
                TextField(
                  controller: _emailController,
                  keyboardType:
                      TextInputType.emailAddress, // Keyboard khusus email (@)
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Masukkan Gmail Anda",
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ), // Tambahan ikon email
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                        color: primaryBlue,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 80),

                // 4. Tombol Simpan
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // Tambahkan aksi saat tombol simpan ditekan (termasuk validasi email)
                      print("Email disimpan: ${_emailController.text}");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
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
