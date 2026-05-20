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
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Menyamakan warna background dasar
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Mengeset default halaman aktif ke 'Beranda'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Search Bar
              const CustomSearchBar(),
              const SizedBox(height: 24),

              // 2. Jadwal Pemeriksaan Section
              const SectionTitle(title: 'Jadwal Pemeriksaan'),
              const SizedBox(height: 12),
              const ScheduleCard(),
              const SizedBox(height: 24),

              // 3. Pengingat Section
              SectionHeaderWithLink(
                title: 'Pengingat',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              const ReminderItem(),
              const SizedBox(height: 8),
              const ReminderItem(),
              const SizedBox(height: 8),
              const ReminderItem(),
              const SizedBox(height: 24),

              // 4. Riwayat Penanganan Section
              const SectionTitle(title: 'Riwayat Penanganan'),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Mei 2026',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD2E5F9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Terbaru',
                      style: TextStyle(color: Color(0xFF1E88E5), fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const HistoryItem(date: '18'),
              const SizedBox(height: 12),
              const HistoryItem(date: '2'),
              const SizedBox(height: 12),
              const HistoryItem(date: '1'),
              const SizedBox(height: 16),

              // View More Center Link
              Center(
                child: TextButton(
                  // TextButton menerima 'onPressed', lalu kita panggil fungsi di dalamnya
                  onPressed: () {
                    // Masukkan aksi kamu di sini
                  },
                  child: const Text(
                    'Lihat Lebih Banyak',
                    style: TextStyle(
                      color: Colors.black54, 
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // --- TAMBAHAN: BOTTOM NAVIGATION BAR KUSTOM ---
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
            _buildBottomNavItem(0, Icons.home_rounded, 'Beranda'), // Diubah ke home_rounded agar pas saat aktif
            _buildCenterScanningButton(),
            _buildBottomNavItem(2, Icons.person_outline_rounded, 'Akun'),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Item Navigasi Biasa (Beranda / Akun)
  Widget _buildBottomNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        // Sstt.. Jika mau pindah page betulan, bisa taruh logika Navigator di sini
      },
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

  // Helper Widget: Tombol Cetak Scanning Biru Menjoljol di Tengah
  Widget _buildCenterScanningButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, -10), // Memberikan efek melayang ke atas melewati batas bar
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3),
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

// ================= COMPONENT WIDGETS (SAMA SEPERTI SEBELUMNYA) =================

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Ketuk untuk mencari',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          suffixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}

class SectionHeaderWithLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SectionHeaderWithLink({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            'Lihat Lebih Banyak',
            style: TextStyle(color: Colors.black54, decoration: TextDecoration.underline, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD2E5F9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'MEI 2026',
                    style: TextStyle(color: Color(0xFF1E88E5), fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('15', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    const Text('16', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    const Text('17', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFF1E88E5),
                          child: Text('18', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Text('19', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    const Text('20', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    const Text('21', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(30, (index) => Expanded(
              child: Container(
                color: index % 2 == 0 ? Colors.transparent : Colors.grey.withOpacity(0.3),
                height: 1.5,
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFF1E88E5),
                  child: Icon(Icons.calendar_today, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'RS UMMI BOGOR',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                    ),
                    Text(
                      'Flu dan batuk',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ReminderItem extends StatelessWidget {
  const ReminderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFF5C6BC0),
            child: Icon(Icons.nights_stay, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Antibiotik',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                '1 Kali Setelah Makan',
                style: TextStyle(color: Colors.grey[500], fontSize: 11),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String date;
  const HistoryItem({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF1E88E5),
            child: Text(
              date,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RS UMMI BOGOR',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  'Flu dan batuk',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Sembuh Total',
                    style: TextStyle(color: Color(0xFF4CAF50), fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_rounded, color: Color(0xFF1E88E5)),
          ),
        ],
      ),
    );
  }
}