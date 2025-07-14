import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../../../data_models/Quote_model.dart';

class QuoteDisplay extends StatelessWidget {
  final QuoteModel? quote;
  final String? errorMessage;
  final String? initialMessage;
  final String defaultText;

  const QuoteDisplay({
    super.key,
    this.quote,
    this.errorMessage,
    this.initialMessage,
    this.defaultText = "Tap button to fetch data!",
  });

  @override
  Widget build(BuildContext context) {
    print(
      "QUOTE DISPLAY: Building. Quote: ${quote?.content}, Error: $errorMessage, Initial: $initialMessage",
    );
    String textToShow;
    String? authorText;
    bool isError = false;

    if (errorMessage != null) {
      textToShow = errorMessage!;
      isError = true;
    } else if (quote != null) {
      textToShow = quote!.content;
      authorText = quote!.author;
    } else if (initialMessage != null) {
      textToShow = initialMessage!;
    } else {
      textToShow = defaultText; // Use defaultText instead
    }

    final bool isEmpty =
        (quote == null && errorMessage == null && initialMessage == null) ||
        textToShow == defaultText;

    if (isEmpty && !isError) {
      return FadeIn(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(Icons.format_quote, size: 64, color: Colors.green.shade600),
              const SizedBox(height: 16),
              Text(
                "Tap button to fetch data!",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Pulse(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        decoration: BoxDecoration(
          gradient: isError
              ? LinearGradient(
                  colors: [Colors.red.shade50, Colors.red.shade100],
                )
              : LinearGradient(
                  colors: [
                    Colors.green.shade50,
                    Colors.teal.shade50,
                    Colors.cyan.shade50,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(20.0),
          border: isError
              ? Border.all(color: Colors.red.shade300, width: 1.5)
              : Border.all(color: Colors.green.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: isError
                  ? Colors.red.withOpacity(0.1)
                  : Colors.green.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              if (!isError) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.format_quote,
                      size: 28,
                      color: Colors.green.shade700,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Quote",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ] else ...[
                Icon(Icons.error_outline, size: 32, color: Colors.red.shade600),
                const SizedBox(height: 16),
              ],
              Text(
                textToShow,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 17.0,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                  fontStyle: quote != null
                      ? FontStyle.italic
                      : FontStyle.normal,
                  color: isError
                      ? Colors.red.shade800
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              if (authorText != null && !isError) ...[
                const SizedBox(height: 20),
                Container(
                  height: 2,
                  width: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade400, Colors.teal.shade400],
                    ),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "— $authorText",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
              if (!isError && quote != null) ...[
                const SizedBox(height: 16),
                Container(
                  height: 3,
                  width: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade400, Colors.teal.shade400],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
