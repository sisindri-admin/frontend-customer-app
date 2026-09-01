import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String _verificationId = '';
  int? _resendToken;
  String _phoneNumber = '';
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String get phoneNumber => _phoneNumber;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _authService.currentUser != null;
  User? get currentUser => _authService.currentUser;

  // Send OTP
  Future<bool> sendOTP(String phone, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    _phoneNumber = phone;
    notifyListeners();

    bool isSent = false;

    try {
      await _authService.sendOTP(
        phoneNumber: phone,
        resendToken: _resendToken,
        onCodeSent: (verificationId, resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
          _isLoading = false;
          isSent = true;
          notifyListeners();
        },
        onVerificationFailed: (e) {
          _isLoading = false;
          _errorMessage = e.message ?? 'OTP verification failed';
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_errorMessage!), backgroundColor: Colors.red),
          );
        },
        onAutoVerified: (credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          _isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }

    return isSent;
  }

  // Verify OTP
  Future<bool> verifyOTP(String otp, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.verifyOTPAndSignIn(
        verificationId: _verificationId,
        smsCode: otp,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      _errorMessage = e.message ?? 'Invalid OTP';
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
}