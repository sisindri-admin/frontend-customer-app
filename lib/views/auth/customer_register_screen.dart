import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../main_navigation_screen.dart';

class CustomerRegisterScreen extends StatefulWidget {
  const CustomerRegisterScreen({super.key});

  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  String _selectedArea = 'VRC Centre';

  final List<String> _nelloreAreas = [
    'VRC Centre',
    'Magunta Layout',
    'Gandhi Nagar',
    'Dargamitta',
    'Mini Bypass Road',
    'Vedayapalem',
    'Stonehousepet',
    'Childrens Park Area',
    'Chinthareddypalem',
    'Nawabpet',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister() async {
    if (_formKey.currentState!.validate()) {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final success = await auth.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: _phoneController.text,
        area: _selectedArea,
        context: context,
      );

      if (success && mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'కొత్త ఖాతా సృష్టించండి',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 6),
                const Text(
                  'మీ వివరాలు నమోదు చేసి Flash 2 Mart లో చేరండి.',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 24),

                // Full Name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'పూర్తి పేరు (Full Name)',
                    prefixIcon: const Icon(Icons.person_outline, color: AppColors.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: AppColors.background,
                  ),
                  validator: (val) => val == null || val.isEmpty ? 'దయచేసి పేరు నమోదు చేయండి' : null,
                ),
                const SizedBox(height: 16),

                // Mobile Number
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'మొబైల్ నంబర్ (Phone Number)',
                    prefixText: '+91 ',
                    counterText: '',
                    prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: AppColors.background,
                  ),
                  validator: (val) => val == null || val.length != 10 ? '10 అంకెల మొబైల్ నంబర్ ఇవ్వండి' : null,
                ),
                const SizedBox(height: 16),

                // Nellore Area Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedArea,
                  decoration: InputDecoration(
                    labelText: 'నెల్లూరు డెలివరీ ఏరియా (Delivery Area)',
                    prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: AppColors.background,
                  ),
                  items: _nelloreAreas.map((area) {
                    return DropdownMenuItem(value: area, child: Text(area));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedArea = val);
                  },
                ),
                const SizedBox(height: 16),

                // Email
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
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'పాస్‌వర్డ్ (Password)',
                    prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: AppColors.background,
                  ),
                  validator: (val) => val == null || val.length < 6 ? 'పాస్‌వర్డ్ కనీసం 6 అక్షరాలు ఉండాలి' : null,
                ),

                const SizedBox(height: 28),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: auth.isLoading ? null : _onRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: auth.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'ఖాతా సృష్టించండి (Create Account)',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}