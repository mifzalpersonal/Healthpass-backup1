import 'package:flutter/material.dart';

// Helper untuk mendapatkan nama bulan singkat bahasa Indonesia
String _getBulanIndo(int bulan) {
  const bulanIndo = [
    "Jan", "Feb", "Mar", "Apr", "Mei", "Jun", 
    "Jul", "Agu", "Sep", "Okt", "Nov", "Des"
  ];
  return bulanIndo[bulan - 1];
}

// ==========================================
// 1. HALAMAN DETAIL JADWAL PEMERIKSAAN (ON-GOING & HISTORY)
// ==========================================
class DetailJadwalPage extends StatelessWidget {
  final List appointments;
  const DetailJadwalPage({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),
      appBar: AppBar(
        title: const Text("Jadwal Pemeriksaan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xff334155))),
        backgroundColor: const Color(0xfff8fafc),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: appointments.isEmpty
          ? const Center(child: Text("Tidak ada jadwal kontrol", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final item = appointments[index];
                DateTime? appDate;
                if (item["appointment_date"] != null) {
                  appDate = DateTime.parse(item["appointment_date"]);
                }

                // Menentukan apakah jadwal ini masih aktif (on-going) atau sudah lewat (history)
                bool isOngoing = appDate != null && !appDate.isBefore(DateTime(now.year, now.month, now.day));

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))
                    ],
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Kotak Indikator Tanggal Sebelah Kiri (Sesuai Desain Anda)
                        Container(
                          width: 85,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: isOngoing ? const Color(0xff3b82f6) : const Color(0xff94a3b8),
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                appDate != null ? "${appDate.day}" : "--",
                                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, height: 1.1),
                              ),
                              Text(
                                appDate != null ? _getBulanIndo(appDate.month) : "-",
                                style: const TextStyle(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        // Konten Informasi di Sebelah Kanan
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Jadwal Pemeriksaan",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xff1e293b)),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item["rs_name"] ?? "Nama RS tidak tersedia",
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  item["notes"] ?? "Flu dan batuk",
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  "Waktu : 10:00 - 11:00",
                                  style: TextStyle(color: Color(0xff475569), fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ==========================================
// 2. HALAMAN DETAIL PENGINGAT OBAT (DAFTAR OBAT JALAN)
// ==========================================
class DetailObatPage extends StatelessWidget {
  final Map<String, dynamic>? medication;
  const DetailObatPage({super.key, this.medication});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),
      appBar: AppBar(
        title: const Text("Pengingat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xff334155))),
        backgroundColor: const Color(0xfff8fafc),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: Color(0xff3b82f6)),
            onPressed: () {},
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: medication == null
          ? const Center(child: Text("Tidak ada jadwal konsumsi obat aktif", style: TextStyle(color: Colors.grey)))
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))
                    ],
                  ),
                  child: Row(
                    children: [
                      // Ikon Obat dengan Lingkaran Oranye/Ungu Sesuai Mockup Anda
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(color: Color(0xfffaf5ff), shape: BoxShape.circle),
                        child: const Icon(Icons.blur_circular, color: Colors.purpleAccent, size: 26),
                      ),
                      const SizedBox(width: 16),
                      // Detail Teks Tengah
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              medication!["medicine_name"] ?? "-",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xff1e293b)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              medication!["rules"] ?? "1 Kali sehari",
                              style: const TextStyle(color: Color(0xff3b82f6), fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Setiap Hari - Rutin",
                              style: TextStyle(color: Colors.grey, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      // Tampilan Waktu Jam di Kanan (Sesuai Desain Anda)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            medication!["remind_at"] != null 
                                ? medication!["remind_at"].toString().substring(0, 5) 
                                : "18:00",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xff334155)),
                          ),
                          const Text("WIB", style: TextStyle(color: Colors.grey, fontSize: 10)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// ==========================================
// 3. HALAMAN DETAIL RIWAYAT REKAM MEDIS Pasien
// ==========================================
class DetailRiwayatPage extends StatelessWidget {
  final List history;
  const DetailRiwayatPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),
      appBar: AppBar(
        title: const Text("Riwayat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xff334155))),
        backgroundColor: const Color(0xfff8fafc),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: history.isEmpty
          ? const Center(child: Text("Belum ada riwayat rekam medis", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                
                // Parser tanggal pembuatan rekam medis
                String tanggalFormat = "Bulan Lalu";
                if (item["created_at"] != null) {
                  DateTime parsedDate = DateTime.parse(item["created_at"]);
                  tanggalFormat = "${parsedDate.day} ${_getBulanIndo(parsedDate.month)} ${parsedDate.year}";
                }

                // Logika pemetaan warna badge status berobat (Sembuh, Rawat Jalan, Rawat Inap)
                String statusText = item["patient_status"] ?? "Sembuh Total";
                Color badgeBgColor = const Color(0xffdcfce7);
                Color badgeTextColor = const Color(0xff16a34a);

                if (statusText.toLowerCase().contains("jalan")) {
                  badgeBgColor = const Color(0xffe0f2fe);
                  badgeTextColor = const Color(0xff0284c7);
                } else if (statusText.toLowerCase().contains("inap")) {
                  badgeBgColor = const Color(0xfffee2e2);
                  badgeTextColor = Colors.red;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 6, offset: const Offset(0, 2))
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Informasi rekam medis kiri
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["room"]?["name"] ?? "RS UMMI BOGOR",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xff1e293b)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item["disease"]?["name"] ?? "Flu dan batuk",
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                            ),
                            const SizedBox(height: 10),
                            // Badge Status Dinamis (Sembuh/Rawat Inap/Rawat Jalan)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: badgeBgColor, borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                statusText,
                                style: TextStyle(color: badgeTextColor, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Info tanggal pemeriksaan kanan
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("Tanggal pemeriksaan:", style: TextStyle(color: Colors.grey, fontSize: 10)),
                          const SizedBox(height: 2),
                          Text(
                            tanggalFormat,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xff475569)),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}