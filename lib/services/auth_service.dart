import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  // 1. Send OTP to Mobile Number
  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(FirebaseAuthException e) onVerificationFailed,
    required Function(PhoneAuthCredential credential) onAutoVerified,
    int? resendToken,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: onAutoVerified,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: resendToken,
      timeout: const Duration(seconds: 60),
    );
  }

  // 2. Verify OTP and Sign In
  Future<UserCredential> verifyOTPAndSignIn({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    
    // Check & Save Customer profile in Firestore
    if (userCredential.user != null) {
      await _syncCustomerProfile(userCredential.user!);
    }

    return userCredential;
  }

  // 3. Save/Update Customer Profile in Firestore
  Future<void> _syncCustomerProfile(User user) async {
    final userDoc = _firestore.collection('customers').doc(user.uid);
    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      await userDoc.set({
        'uid': user.uid,
        'phoneNumber': user.phoneNumber,
        'name': '',
        'city': 'Nellore',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // 4. Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}