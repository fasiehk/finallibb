import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/saved_books_provider.dart';
import '../services/book_service.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final int? coverId;
  final String bookKey;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    this.coverId,
    required this.bookKey,
  });

  @override
  Widget build(BuildContext context) {
    final isSaved = Provider.of<SavedBooksProvider>(context)
        .isBookSaved(bookKey); // Check if the book is saved

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Book Cover Image
            if (coverId != null)
              Image.network(
                'https://covers.openlibrary.org/b/id/$coverId-L.jpg',
                width: 50,
                height: 75,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 50),
              )
            else
              const Icon(Icons.book, size: 50, color: Colors.grey),
            const SizedBox(width: 16),
            // Book Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    author,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Save/Unsave Button
            IconButton(
              onPressed: () async {
                if (isSaved) {
                  // Remove the book if it is already saved
                  await Provider.of<SavedBooksProvider>(context, listen: false)
                      .removeBook(Book(
                    title: title,
                    author: author,
                    key: bookKey,
                    coverId: coverId,
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title removed!')),
                  );
                } else {
                  // Save the book if it is not already saved
                  await Provider.of<SavedBooksProvider>(context, listen: false)
                      .addBook(Book(
                    title: title,
                    author: author,
                    key: bookKey,
                    coverId: coverId,
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title saved!')),
                  );
                }
              },
              icon: Icon(
                isSaved ? Icons.bookmark_remove : Icons.bookmark_add,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
