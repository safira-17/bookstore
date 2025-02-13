import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../services/api_service.dart';
import 'edit_book_page.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Author: ${book.author}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Year: ${book.year}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: EditBookPage(book: book),
                          );
                        },
                      ),
                    );
                  },
                  child: Text('Edit', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    await ApiService().deleteBook(book.id);
                    Navigator.pop(context);
                  },
                  child: Text('Delete', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}