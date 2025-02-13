class Book {
  String id;
  String title;
  String author;
  int year;

  Book({required this.id, required this.title, required this.author, required this.year});

  factory Book.fromMap(Map<String, dynamic> data, String id) {
    return Book(
      id: id,
      title: data['title'],
      author: data['author'],
      year: data['year'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'year': year,
    };
  }
}