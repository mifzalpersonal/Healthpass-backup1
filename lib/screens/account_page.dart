import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final String token;

  const AccountPage({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Akun Pasien",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}