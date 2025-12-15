
// ============================================
// FILE: lib/screens/login/login_screen.dart
// ============================================
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/routes.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _otpSent = true);
      
      // Mock OTP send
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent! Use 123456 for testing'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _verifyOTP() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authProvider.notifier).login(
        _phoneController.text,
        _otpController.text,
      );

      final authState = ref.read(authProvider);
      
      if (authState.isAuthenticated) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, Routes.home);
      } else if (authState.error != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authState.error!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Icon(
                Icons.lock_outline,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Login to file and track grievances',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 48),
              
              // Phone Number Field
              CustomTextField(
                label: 'Phone Number',
                hint: 'Enter 10 digit mobile number',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
                prefixIcon: const Icon(Icons.phone),
                enabled: !_otpSent,
              ),
              const SizedBox(height: 16),
              
              // OTP Field (conditional)
              if (_otpSent) ...[
                CustomTextField(
                  label: 'OTP',
                  hint: 'Enter 6 digit OTP',
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  validator: Validators.validateOTP,
                  prefixIcon: const Icon(Icons.security),
                  maxLength: 6,
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => setState(() => _otpSent = false),
                  child: const Text('Change Phone Number'),
                ),
              ],
              
              const SizedBox(height: 24),
              
              // Action Button
              CustomButton(
                text: _otpSent ? 'Verify OTP' : 'Send OTP',
                onPressed: _otpSent ? _verifyOTP : _sendOTP,
                isLoading: authState.isLoading,
              ),
              
              if (!_otpSent) ...[
                const SizedBox(height: 16),
                Text(
                  'You will receive an OTP for verification',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

