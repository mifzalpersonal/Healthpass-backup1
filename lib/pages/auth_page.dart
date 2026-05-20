import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // Welcome Text
                  Text(
                    _isLogin
                    ?
                      'Masuk'
                    :
                      'Daftar',
                    
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  // Sub Text
                  Text(
                    _isLogin
                    ?
                      'Pantau Terus Passport Kesehatanmu!'
                    :
                      'Buat akun baru untuk mulai menggunakan layanan passport kesehatan digital.',
                  
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  
                  SizedBox(height: 50),
                ],
              ),
            ),

            // Textfield (NIK, Email, Password, No. Telp, BPJS)
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [

                    if(!_isLogin)...[
                      // Email Textfield
                      TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
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
                            borderRadius: BorderRadius.circular(10)
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
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                    ),

                  if(!_isLogin)...[
                    SizedBox(height: 20),

                    // BPJS Textfield
                    TextFormField(
                      controller: _bpjsController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'No.BPJS',
                        prefixIcon: Icon(Icons.card_membership_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  ],

                  if (!_isLogin) ...[
                    const SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4, 
                          child: IntlPhoneField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 30),
                              filled: true,
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            initialCountryCode: 'ID',
                            showCursor: false,
                            disableLengthCheck: true,
                            dropdownIconPosition: IconPosition.trailing,
                            flagsButtonPadding: const EdgeInsets.only(left: 12),
                            dropdownTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            style: const TextStyle(fontSize: 0), 
                            onChanged: (phone) {
                            },
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            controller: _noController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Nomer Telepon',
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ],
              ),
            ),
          ),

          SizedBox(height: 50),

          // Auth Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              onPressed: (){
                if (_formKey.currentState!.validate()){
                  print(
                    _isLogin
                    ?
                      'Tombol Masuk ditekan'
                    :
                      'Tombol Daftar ditekan'
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 55),
              ),
              child: Text(
                _isLogin
                ?
                  'Masuk'
                :
                  'Daftar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
          ),

          SizedBox(height: 70),

          // Footer Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Privasi, keamanan, dan kenyamanan pengguna adalah prioritas kami.',
              style: TextStyle(
                fontSize: 14
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 30),

          // Auth Options
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isLogin
                ?
                  'Belum Punya Akun?'
                :
                  'Sudah Punya Akun?'
              ),

              SizedBox(width: 10),

              GestureDetector(
                onTap: () {
                  
                },
                child: Text(
                  _isLogin
                  ?
                    'Daftar'
                  :
                    'Masuk',
                
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent
                  ),
                ),
              )
            ],
          )

        ],
        ),
      ),
    );
  }
}