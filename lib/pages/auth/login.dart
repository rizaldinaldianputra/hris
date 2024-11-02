// lib/ui/login_page.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/service/auth_services.dart';
import 'package:hris/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider untuk mengatur state loading
final loadingProvider = StateProvider<bool>((ref) => false);

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscure = true;

  Future<void> doLogin(String email, String password) async {
    ref.read(loadingProvider.notifier).state = true; // Set loading ke true

    final authService = AuthService();
    final response = await authService.login(email, password);

    ref.read(loadingProvider.notifier).state = false; // Set loading ke false

    if (response['success']) {
      context.pushReplacementNamed('home');
      // Mengambil data user setelah login sukses
      final userService = UserService(context);
      final user = await userService.findUser();

      // Konversi objek Users ke JSON string dan simpan ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toJson()); // Konversi ke JSON
      prefs.setString('user', userJson);
    } else {
      Fluttertoast.showToast(
        msg: response['message'] ?? "Login Gagal. Silakan coba lagi.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider); // Watch loading state

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
                    colors: [HexColor('#01A2E9'), HexColor('#274896')],
                  ),
                ),
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
              ),
            ],
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: const EdgeInsets.all(16),
              height: 450,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/newlogo.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Sign In ke Aplikasi',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.black,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
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
                        hintText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _isPasswordObscure,
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
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: HexColor('#01A2E9'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : () async {
                            await doLogin(
                              _emailController.text,
                              _passwordController.text,
                            );
                          },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(200),
                        ),
                        color: isLoading ? Colors.grey : HexColor('#01A2E9'),
                      ),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                'Sign In',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
