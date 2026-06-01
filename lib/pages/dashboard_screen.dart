import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Latar belakang abu-abu terang (Slate 100)
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // KONTEN UTAMA DASHBOARD
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  
                  const Text(
                    "Jadwal Pemeriksaan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildDateStrip(),
                  const SizedBox(height: 24),
                  
                  _buildScheduleCard(),
                  const SizedBox(height: 16),
                  
                  _buildMedicationCard(),
                  const SizedBox(height: 24),
                  
                  _buildPassportCard(),
                  const SizedBox(height: 32),
                  
                  const Text(
                    "Riwayat",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildHistoryCard(),
                ],
              ),
            ),

            // CUSTOM BOTTOM NAVIGATION BAR
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildCustomBottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET KOMPONEN ---

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Tombol Notifikasi
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFF3B82F6),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.notifications, color: Colors.white, size: 20),
        ),
        // Search Bar
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Ketuk untuk mencari",
              hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateStrip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDateItem("16", false, false),
        _buildDateItem("17", false, false),
        _buildDateItem("18", false, false),
        // Tanggal Aktif (Hari ini)
        Column(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFFDBEAFE),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text("19", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3B82F6))),
              ),
            ),
            const SizedBox(height: 4),
            const Text("Hari ini", style: TextStyle(fontSize: 10, color: Color(0xFF3B82F6), fontWeight: FontWeight.w600)),
          ],
        ),
        // Tanggal Outline (Besok)
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF3B82F6), width: 1.5),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text("20", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
          ),
        ),
        _buildDateItem("21", false, false),
        _buildDateItem("22", false, false),
      ],
    );
  }

  Widget _buildDateItem(String day, bool isSelected, bool isOutlined) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        day,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF64748B)),
      ),
    );
  }

  Widget _buildScheduleCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          // Sisi Kiri: Tanggal
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("20", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF3B82F6))),
              Text("Mei", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF3B82F6))),
            ],
          ),
          const SizedBox(width: 24),
          // Sisi Kanan: Detail
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Jadwal Kontrol Berikutnya", style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                SizedBox(height: 4),
                Text("RS UMMI BOGOR", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                Text("Flu dan batuk", style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                SizedBox(height: 12),
                Text("Waktu : 10:00 - 11:00", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF475569))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMedicationCard() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: Color(0xFF6366F1), shape: BoxShape.circle),
                child: const Icon(Icons.nightlight_round, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Antibiotik", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                    Text("1 Kali Setelah Makan", style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                  ],
                ),
              ),
              const Text("18:00", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Pengingat akan menyala dalam 4 jam",
          style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildPassportCard() {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4496FF), Color(0xFF2E7BFF)], // Gradasi Biru
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: const Color(0xFF3B82F6).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: Stack(
        children: [
          // Isi Kartu
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Tiruan Gambar Bendera Indonesia
                Container(
                  width: 40,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Column(
                    children: [
                      Expanded(child: Container(decoration: const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.vertical(top: Radius.circular(4))))),
                      Expanded(child: Container(decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(bottom: Radius.circular(4))))),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Passport Kesehatan", style: TextStyle(fontSize: 11, color: Colors.white70)),
                    SizedBox(height: 4),
                    Text("Ahmad F. Ahla", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          // Pita Kuning (Bookmark) di Kanan Atas
          Positioned(
            top: 0,
            right: 24,
            child: Icon(Icons.bookmark, color: const Color(0xFFFBBF24), size: 40), // Warna Amber/Kuning
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("RS UMMI BOGOR", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                const SizedBox(height: 2),
                const Text("Flu dan batuk", style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBBF7D0), // Hijau pastel
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Sembuh Total",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF16A34A)),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Tanggal pemeriksaan:", style: TextStyle(fontSize: 9, color: Color(0xFF94A3B8))),
              const SizedBox(height: 2),
              const Text("18 Mei 2026", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
            ],
          ),
          const SizedBox(width: 16),
          // Tombol Panah Biru
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: Color(0xFF3B82F6), shape: BoxShape.circle),
            child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomBottomNavBar() {
    return SizedBox(
      height: 90,
      child: Stack(
        children: [
          // Latar Belakang Putih Nav Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Tab Beranda
                  GestureDetector(
                    onTap: () => setState(() => _selectedIndex = 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_outlined, 
                            color: _selectedIndex == 0 ? const Color(0xFF334155) : const Color(0xFF94A3B8), 
                            size: 28),
                        const SizedBox(height: 4),
                        Text("Beranda", 
                            style: TextStyle(
                              fontSize: 12, 
                              color: _selectedIndex == 0 ? const Color(0xFF334155) : const Color(0xFF94A3B8),
                              fontWeight: _selectedIndex == 0 ? FontWeight.bold : FontWeight.normal
                            )),
                      ],
                    ),
                  ),
                  
                  // Jarak Tengah untuk tombol Scanner
                  const SizedBox(width: 60),
                  
                  // Tab Akun
                  GestureDetector(
                    onTap: () => setState(() => _selectedIndex = 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_outline, 
                            color: _selectedIndex == 2 ? const Color(0xFF334155) : const Color(0xFF94A3B8), 
                            size: 28),
                        const SizedBox(height: 4),
                        Text("Akun", 
                            style: TextStyle(
                              fontSize: 12, 
                              color: _selectedIndex == 2 ? const Color(0xFF334155) : const Color(0xFF94A3B8),
                              fontWeight: _selectedIndex == 2 ? FontWeight.bold : FontWeight.normal
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Tombol Scanner Melayang di Tengah
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 2 - 35,
            child: GestureDetector(
              onTap: () => setState(() => _selectedIndex = 1),
              child: Column(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6), // Biru utama
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF3B82F6).withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: 6),
                  const Text("Scanning", style: TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}