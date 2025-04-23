import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final int? coverId;
  final VoidCallback onSave;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    this.coverId,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
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
              CachedNetworkImage(
                imageUrl: 'https://covers.openlibrary.org/b/id/$coverId-L.jpg',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image, size: 50),
                width: 50,
                height: 75,
                fit: BoxFit.cover,
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
            // Save Button
            IconButton(
              onPressed: onSave,
              icon: const Icon(Icons.bookmark_add, color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
