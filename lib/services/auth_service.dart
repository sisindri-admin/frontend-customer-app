import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  // 1. Customer Registration
  Future<UserCredential> registerCustomer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String area,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    if (credential.user != null) {
      await _firestore.collection('customers').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'name': name.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'area': area.trim(),
        'city': 'Nellore',
        'role': 'customer',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return credential;
  }

  // 2. Customer Login
  Future<UserCredential> loginCustomer({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // 3. Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}