import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class FetchButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String label;
  final String loadingLabel;
  final IconData iconData;

  const FetchButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    required this.label,
    this.loadingLabel = 'Fetching...',
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLoading
                ? [Colors.grey.shade400, Colors.grey.shade500]
                : [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: isLoading ? null : onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading)
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    )
                  else
                    Icon(
                      iconData,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 20,
                    ),
                  const SizedBox(width: 12),
                  Text(
                    isLoading ? loadingLabel : label,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
