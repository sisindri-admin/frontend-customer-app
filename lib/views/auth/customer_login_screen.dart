import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../main_navigation_screen.dart';
import 'customer_register_screen.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() async {
    if (_formKey.currentState!.validate()) {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final success = await auth.login(
        _emailController.text,
        _passwordController.text,
        context,
      );

      if (success && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                // Brand Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.flash_on, color: AppColors.primary, size: 28),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Flash 2 Mart',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'కస్టమర్ లాగిన్ (Customer Login)',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 6),
                const Text(
                  'నెల్లూరులో 15 నిమిషాల్లో కిరాణా & మందులు పొందడానికి లాగిన్ అవ్వండి.',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 32),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'ఇమెయిల్ (Email)',
                    prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: AppColors.background,
                  ),
                  validator: (val) => val == null || !val.contains('@') ? 'సరైన ఇమెయిల్ ఇవ్వండి' : null,
                ),
                const SizedBox(height: 18),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'పాస్‌వర్డ్ (Password)',
                    prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: AppColors.textMuted),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: AppColors.background,
                  ),
                  validator: (val) => val == null || val.length < 6 ? 'పాస్‌వర్డ్ కనీసం 6 అక్షరాలు ఉండాలి' : null,
                ),

                const SizedBox(height: 30),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: auth.isLoading ? null : _onLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: auth.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'లాగిన్ అవ్వండి (Login)',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                // Register Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ఖాతా లేదా? ', style: TextStyle(color: AppColors.textSecondary)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CustomerRegisterScreen()),
                        );
                      },
                      child: const Text(
                        'ఇప్పుడే రిజిస్టర్ అవ్వండి (Register)',
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}