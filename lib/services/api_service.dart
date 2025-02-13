// api_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book_model.dart';

class ApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Book>> getBooks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('books').get();
      return querySnapshot.docs
          .map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to load books: $e');
    }
  }

  Future<void> addBook(Book book) async {
    await _firestore.collection('books').add(book.toMap());
  }

  Future<void> updateBook(Book book) async {
    await _firestore.collection('books').doc(book.id).update(book.toMap());
  }

  Future<void> deleteBook(String id) async {
    await _firestore.collection('books').doc(id).delete();
  }
}