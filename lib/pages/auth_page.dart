import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = false;
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _noController = TextEditingController();
  final _bpjsController = TextEditingController();
  final _nameEmailBpjsController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _noController.dispose();
    _bpjsController.dispose();
    _nameEmailBpjsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Logo/Icon
            Icon(
              Icons.health_and_safety_outlined,
              size: 80,
              color: Colors.blueAccent,
            ),

            SizedBox(height: 30),

            // Welcome Text
            Text(
              _isLogin
              ?
                'Selamat Datang Kembali'
              :
                'Selamat Datang',
              
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),

            // Sub Text
            Text(
              _isLogin
              ?
                'Pantau Terus Passport Kesehatanmu!'
              :
                'Masuk untuk Mendapatkan Passport Kesehatan!',

              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 80),

            // Textfield (NIK, Email, Password, No. Telp, BPJS)
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [

                    if(!_isLogin)...[
                      // NIK Textfield
                      TextFormField(
                        controller: _bpjsController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'No.BPJS',
                          prefixIcon: Icon(Icons.card_membership_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                      ),

                      SizedBox(height: 20),

                      // Email Textfield
                      TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                      )]
                    else...[
                      TextFormField(
                        controller: _nameEmailBpjsController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Nama, Email/No.BPJS',
                          prefixIcon: Icon(Icons.person_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                      ),
                    ],

                    SizedBox(height: 20),

                    // Password Textfield
                    SensitiveContent(
                      sensitivity: ContentSensitivity.sensitive,
                      child: 
                      TextFormField(
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: 'Kata Sandi',
                          prefixIcon: Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              _isObscure = !_isObscure;
                            }),
                            icon: Icon(_isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ),
                    ),

                  if(!_isLogin)...[
                    Row(
                      children: [
                          
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ),

            // Auth Button

            // Auth Options


          ],
        ),
      ),
    );
  }
}