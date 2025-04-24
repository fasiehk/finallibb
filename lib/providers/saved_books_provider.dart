import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/book_service.dart';

class SavedBooksProvider extends ChangeNotifier {
  final List<Book> _savedBooks = [];

  List<Book> get savedBooks => List.unmodifiable(_savedBooks);

  Future<void> fetchSavedBooks() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final response = await Supabase.instance.client
        .from('saved_books')
        .select()
        .eq('user_id', user.id)
        .execute();

    if (response.status == 200 && response.data != null) {
      _savedBooks.clear();
      for (var book in response.data) {
        _savedBooks.add(Book(
          title: book['title'],
          author: book['author'],
          key: book['book_key'],
          coverId: book['cover_id'],
        ));
      }
      notifyListeners();
    } else {
      throw Exception('Failed to fetch saved books');
    }
  }

  Future<void> addBook(Book book) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final response = await Supabase.instance.client.from('saved_books').insert({
      'user_id': user.id,
      'book_key': book.key,
      'title': book.title,
      'author': book.author,
      'cover_id': book.coverId,
    }).execute();

    if (response.status == 201) {
      _savedBooks.add(book);
      notifyListeners();
    } else {
      throw Exception('Failed to save book');
    }
  }

  Future<void> removeBook(Book book) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final response = await Supabase.instance.client
        .from('saved_books')
        .delete()
        .eq('user_id', user.id)
        .eq('book_key', book.key)
        .execute();

    if (response.status == 200) {
      _savedBooks.removeWhere((savedBook) => savedBook.key == book.key);
      notifyListeners();
    } else {
      throw Exception('Failed to remove book');
    }
  }

  bool isBookSaved(String bookKey) {
    return _savedBooks.any((book) => book.key == bookKey);
  }
}
