import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 1. లైవ్ ప్రొడక్ట్స్ స్ట్రీమ్ (రియల్ టైమ్ అప్‌డేట్స్)
  Stream<List<ProductModel>> getProducts({String? category}) {
    Query query = _db.collection('products');
    if (category != null && category.isNotEmpty && category != 'All') {
      query = query.where('category', isEqualTo: category);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // 2. కేటగిరీల లిస్ట్ తేవడం
  Stream<List<Map<String, dynamic>>> getCategories() {
    return _db.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'title': data['title'] ?? data['name'] ?? '',
          'icon': data['icon'] ?? '',
        };
      }).toList();
    });
  }

  // 3. కస్టమర్ ఆర్డర్ ప్లేస్ చేయడం
  Future<String> placeOrder({
    required String customerPhone,
    required String deliveryAddress,
    required List<Map<String, dynamic>> items,
    required double totalAmount,
    required String paymentMethod,
  }) async {
    final docRef = await _db.collection('orders').add({
      'customerPhone': customerPhone,
      'deliveryAddress': deliveryAddress,
      'items': items,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'status': 'pending', // pending -> accepted -> packed -> out_for_delivery -> delivered
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }
}