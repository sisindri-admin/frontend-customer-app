import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _authService.currentUser != null;
  User? get currentUser => _authService.currentUser;

  // Customer Login
  Future<bool> login(String email, String password, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.loginCustomer(email: email, password: password);
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = _getFriendlyErrorMessage(e.code);
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!), backgroundColor: Colors.red),
      );
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Customer Register
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String area,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.registerCustomer(
        name: name,
        email: email,
        password: password,
        phone: phone,
        area: area,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = _getFriendlyErrorMessage(e.code);
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!), backgroundColor: Colors.red),
      );
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _authService.signOut();
    notifyListeners();
  }

  String _getFriendlyErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'ఈ ఇమెయిల్‌తో ఖాతా కనుగొనబడలేదు.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'ఇమెయిల్ లేదా పాస్‌వర్డ్ తప్పుగా నమోదు చేయబడింది.';
      case 'email-already-in-use':
        return 'ఈ ఇమెయిల్ ఇప్పటికే నమోదు చేయబడి ఉంది.';
      case 'weak-password':
        return 'పాస్‌వర్డ్ కనీసం 6 అక్షరాలు ఉండాలి.';
      case 'invalid-email':
        return 'సరైన ఇమెయిల్ చిరునామాను నమోదు చేయండి.';
      default:
        return 'లాగిన్ విఫలమైంది. దయచేసి మళ్లీ ప్రయత్నించండి.';
    }
  }
}