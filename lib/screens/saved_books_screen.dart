import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/saved_books_provider.dart';
import '../widgets/book_card.dart';

class SavedBooksScreen extends StatelessWidget {
  const SavedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Books'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder(
        future: Provider.of<SavedBooksProvider>(context, listen: false)
            .fetchSavedBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load saved books: ${snapshot.error}'),
            );
          } else {
            final savedBooks =
                Provider.of<SavedBooksProvider>(context).savedBooks;
            return savedBooks.isEmpty
                ? const Center(
                    child: Text(
                      'Your saved books will appear here.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: savedBooks.length,
                    itemBuilder: (context, index) {
                      final book = savedBooks[index];
                      return BookCard(
                        title: book.title,
                        author: book.author,
                        coverId: book.coverId,
                        bookKey: book.key, // Pass the book key
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}
