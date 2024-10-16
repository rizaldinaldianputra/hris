import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris/pages/attedance_logs/camera_preview.dart';
import 'package:hris/utility/globalwidget.dart';

// Provider untuk mengelola state submit button
final submitButtonProvider = StateProvider<bool>((ref) => false);

class ChangepasswordPage extends ConsumerStatefulWidget {
  const ChangepasswordPage({super.key});

  @override
  _ChangepasswordPageState createState() => _ChangepasswordPageState();
}

class _ChangepasswordPageState extends ConsumerState<ChangepasswordPage> {
  bool _isObscureCurrent = true;
  bool _isObscureNew = true;
  bool _isObscureReenter = true;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _reenterPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Mendapatkan nilai dari provider
    final isSubmitted = ref.watch(submitButtonProvider.notifier).state;

    return Scaffold(
      appBar: appBarWidget('Change Password'),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildPasswordField(
              label: 'Current Password',
              controller: _currentPasswordController,
              isObscure: _isObscureCurrent,
              onChanged: (value) => setState(() {}),
              onToggleVisibility: () {
                setState(() {
                  _isObscureCurrent = !_isObscureCurrent;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              label: 'New Password',
              controller: _newPasswordController,
              isObscure: _isObscureNew,
              onChanged: (value) => setState(() {}),
              onToggleVisibility: () {
                setState(() {
                  _isObscureNew = !_isObscureNew;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              label: 'Re-enter New Password',
              controller: _reenterPasswordController,
              isObscure: _isObscureReenter,
              onChanged: (value) => setState(() {}),
              onToggleVisibility: () {
                setState(() {
                  _isObscureReenter = !_isObscureReenter;
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              'After you update your password, you will be automatically logged out. Log back in with your updated password to verify that your password was changed.',
              maxLines: 3,
              style: GoogleFonts.inter(
                color: HexColor('#878787'),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            _buildChangePasswordButton(),
          ],
        ),
      ),
    );
  }

  // Membuat method untuk membangun TextField
  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isObscure,
    required Function(String) onChanged,
    required VoidCallback onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: HexColor('#333333'),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller,
          obscureText: isObscure,
          onChanged: onChanged, // Panggil setState saat teks berubah
          decoration: InputDecoration(
            hintText: 'input $label'.toLowerCase(),
            hintStyle: GoogleFonts.inter(
              color: HexColor('#878787'),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            labelStyle: const TextStyle(color: Colors.black54),
            suffixIcon: IconButton(
              icon: Icon(
                color: Colors.grey,
                isObscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: onToggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: HexColor('#D9D9D9')),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: HexColor('#D9D9D9')),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: HexColor('#D9D9D9')),
            ),
          ),
        ),
      ],
    );
  }

  // Membuat method untuk tombol "Change Password"
  Widget _buildChangePasswordButton() {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: colorBackground(),
      ),
      child: Center(
        child: Text(
          'Change Password',
          style: GoogleFonts.inter(
            color: colorText(),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _reenterPasswordController.dispose();
    super.dispose();
  }

  Color colorBackground() {
    // Cek apakah ada input di TextField
    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _reenterPasswordController.text.isEmpty) {
      return HexColor('#B3B3B3');
    } else {
      return HexColor('#01A2E9');
    }
  }

  Color colorText() {
    // Cek apakah ada input di TextField
    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _reenterPasswordController.text.isEmpty) {
      return Colors.grey;
    } else {
      return Colors.white;
    }
  }
}
