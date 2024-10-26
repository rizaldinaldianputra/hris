import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris/riverpod/auth.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordObscure = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor('#01A2E9'), HexColor('#274896')])),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.maxFinite,
                child: Opacity(
                  opacity: 1,
                  child: Image.asset(
                    'assets/bg_login.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.all(16),
              height: 400,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/logo.png',
                    width: 56,
                    height: 56,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sign In ke Aplikasi',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Colors.black,
                          letterSpacing: .5),
                    ),
                  ),
                  const SizedBox(height: 40), //

                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: HexColor('#A5A5A5'),
                          ),
                        ),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          // Mengatur border
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        // Icon di awal textfield
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), //
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _isPasswordObscure, // Mengatur obsecure text
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: HexColor('#A5A5A5'),
                          ),
                        ),
                        border: OutlineInputBorder(
                          // Mengatur border
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            color: Colors.grey,
                            _isPasswordObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordObscure = !_isPasswordObscure;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        textStyle:
                            TextStyle(fontSize: 14, color: HexColor('#01A2E9')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  GestureDetector(
                    onTap: () async {
                      await doLogin(
                        context,
                        _emailController.text,
                        _passwordController.text,
                      );
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(200)),
                          color: HexColor('#01A2E9')),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
