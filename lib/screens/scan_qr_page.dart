import 'package:flutter/material.dart';

class ScanQrPage extends StatelessWidget {
  final String token;

  const ScanQrPage({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Scan QR Instansi",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}