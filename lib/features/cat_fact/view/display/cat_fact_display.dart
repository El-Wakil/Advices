import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CatFactDisplay extends StatelessWidget {
  final String textToDisplay;
  final String defaultText;
  final bool isError;

  const CatFactDisplay({
    super.key,
    required this.textToDisplay,
    this.defaultText = "Tap button to fetch data!",
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = textToDisplay.isEmpty || textToDisplay == defaultText;

    if (isEmpty && !isError) {
      return FadeIn(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(
                Icons.pets,
                size: 64,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              ),
              const SizedBox(height: 16),
              Text(
                "Tap the button below to learn a fun cat fact!",
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
                    Colors.orange.shade50,
                    Colors.orange.shade100,
                    Colors.amber.shade50,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(20.0),
          border: isError
              ? Border.all(color: Colors.red.shade300, width: 1.5)
              : Border.all(color: Colors.orange.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: isError
                  ? Colors.red.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.2),
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
                    Icon(Icons.pets, size: 28, color: Colors.orange.shade700),
                    const SizedBox(width: 8),
                    Text(
                      "Cat Fact",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.orange.shade700,
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
                isEmpty ? defaultText : textToDisplay,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 17.0,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                  color: isError
                      ? Colors.red.shade800
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              if (!isError && !isEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  height: 3,
                  width: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange.shade400, Colors.amber.shade400],
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
