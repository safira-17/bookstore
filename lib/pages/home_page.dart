import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/book_model.dart';
import 'add_book_page.dart';
import 'book_detail_page.dart';
import 'about_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  void _loadBooks() {
    setState(() {
      futureBooks = ApiService().getBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookstore', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadBooks();
        },
        child: FutureBuilder<List<Book>>(
          future: futureBooks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No books found'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Book book = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    elevation: 4,
                    child: ListTile(
                      title: Text(book.title, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${book.author} (${book.year})'),
                      onTap: () async {
                        bool? updated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailPage(book: book),
                          ),
                        );
                        if (updated == true) {
                          _loadBooks();
                        }
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? added = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookPage(),
            ),
          );
          if (added == true) {
            _loadBooks();
          }
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}