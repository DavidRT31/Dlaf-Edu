import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveFeedback(String comment,int rating) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "test";

    try {
      await _firestore.collection('feedback').add({
        'userId': userId,
        'comment': comment,
        'rating': rating,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // print('Feedback enviado correctamente');
    } catch (e) {
      // print('Error al enviar el feedback: $e');
      rethrow;
    }
  }
}
