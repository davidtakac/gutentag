import 'package:flutter/material.dart';
import 'package:gutentag/presentation/all_books_state.dart';
import 'package:gutentag/ui/book_screen.dart';
import 'package:gutentag/ui/language_mapping.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.cardState,
  });

  final BookCardState cardState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookScreen(bookId: cardState.id),
          ),
        ),
        child: Row(
          children: [
            cardState.coverUrl == null 
             ? const SizedBox(height: 180, width: 120)
             : Image.network(
                cardState.coverUrl ?? '',
                width: 120,
                height: 180,
                fit: BoxFit.cover,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardState.title, 
                      style: theme.textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      cardState.authors, 
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        cardState.languageCodes.map((code) => getLanguageName(context, code) ?? code).join(', '), 
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      cardState.subjects, 
                      style: theme.textTheme.bodyMedium, 
                      maxLines: 2, 
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}