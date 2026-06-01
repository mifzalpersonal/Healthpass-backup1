import 'package:flutter/material.dart';

class DetailPassportPage extends StatelessWidget {
  final Map<String, dynamic> passportData;

  const DetailPassportPage({super.key, required this.passportData});

  @override
  Widget build(BuildContext context) {
    // Mengekstrak data dari Map API
    final String nama = passportData['patient_name'] ?? "Ahmad F. Ahla";
    final String statusKesehatan = passportData['medical_status'] ?? "Sembuh Total";
    final String golDarah = passportData['blood_type'] ?? "-";
    final String penyakitKritis = passportData['critical_diseases'] ?? "Tidak ada";
    
    // Menggabungkan alergi obat dan makanan (bisa disesuaikan jika bentuknya array/list)
    final String alergiObat = passportData['drug_allergies'] ?? "";
    final String alergiMakanan = passportData['food_allergies'] ?? "";
    final List<String> listAlergi = [];
    if (alergiObat.isNotEmpty && alergiObat != "Tidak ada") listAlergi.add(alergiObat);
    if (alergiMakanan.isNotEmpty && alergiMakanan != "Tidak ada") listAlergi.add(alergiMakanan);

    // Disabilitas
    final List<dynamic> disabilitasRaw = passportData['disabilities'] ?? [];
    final String disabilitas = disabilitasRaw.isNotEmpty ? disabilitasRaw.join(", ") : "Aman";

    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6), // Warna abu-abu terang background
      body: Column(
        children: [
          // ==========================================
          // HEADER BIRU
          // ==========================================
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xff3b82f6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Passport Kesehatan", style: TextStyle(color: Colors.white, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(
                          nama,
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // Icon Pita Bulat Kanan Atas
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.bookmark, color: Color(0xfffbbf24), size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    // Bendera Indonesia Dummy
                    Container(
                      width: 32,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.red,
                      ),
                      child: Column(
                        children: [
                          Expanded(child: Container(color: Colors.red)),
                          Expanded(child: Container(color: Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Ringkasan kesehatan", style: TextStyle(color: Colors.white, fontSize: 12)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            statusKesehatan,
                            style: const TextStyle(color: Color(0xff16a34a), fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),

          // ==========================================
          // KONTEN KARTU STATISTIK
          // ==========================================
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // Baris Pertama: Gol Darah & Alergi
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kartu Gol Darah
                    Expanded(
                      flex: 1,
                      child: _buildStatCard(
                        title: "Gol darah",
                        subtitle: "Tanggal pemeriksaan:\nTerbaru",
                        content: Text(
                          golDarah,
                          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xff1e293b)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Kartu Alergi
                    Expanded(
                      flex: 1,
                      child: _buildStatCard(
                        title: "Alergi",
                        subtitle: "Obat dan lainnya",
                        content: listAlergi.isEmpty
                            ? const Text("Tidak ada alergi", style: TextStyle(color: Colors.grey))
                            : Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: listAlergi.map((alergi) => Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffe0f2fe),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        alergi,
                                        style: const TextStyle(color: Color(0xff3b82f6), fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                    )).toList(),
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Kartu Disabilitas
                _buildStatCard(
                  title: "Dissabilitas",
                  subtitle: "Tanggal pemeriksaan: Terbaru",
                  titleWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(disabilitas, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1e293b))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xffe0f2fe),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text("Aman", style: TextStyle(color: Color(0xff3b82f6), fontSize: 12, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Kartu Penyakit Kritis
                _buildStatCard(
                  title: "Penyakit Kritis",
                  subtitle: "Tanggal pemeriksaan: Terbaru",
                  titleWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(penyakitKritis, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1e293b))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xfffef3c7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text("Perlu pengawasan", style: TextStyle(color: Color(0xffd97706), fontSize: 10, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Fungsi helper pembangun Card agar kode tidak berulang-ulang
  Widget _buildStatCard({
    required String title,
    required String subtitle,
    Widget? content,
    Widget? titleWidget,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (content != null) ...[
            Center(child: content),
            const SizedBox(height: 12),
          ],
          if (titleWidget != null) ...[
            const Text("Penyakit Kritis", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            titleWidget,
          ] else ...[
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff1e293b))),
          ],
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }
}