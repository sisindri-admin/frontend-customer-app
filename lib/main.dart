import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/constants/app_colors.dart';
import 'providers/cart_provider.dart';
import 'providers/auth_provider.dart';
import 'views/auth/customer_login_screen.dart';
import 'views/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Flash2MartCustomerApp());
}

class Flash2MartCustomerApp extends StatelessWidget {
  const Flash2MartCustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'Flash 2 Mart',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primary,
                primary: AppColors.primary,
                background: AppColors.background,
              ),
              scaffoldBackgroundColor: AppColors.background,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
              ),
            ),
            home: auth.isAuthenticated ? const MainNavigationScreen() : const CustomerLoginScreen(),
          );
        },
      ),
    );
  }
}