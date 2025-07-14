import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../advice/view/screens/advice_screen/advice_screen.dart';
import '../cat_fact/view/screens/cat_fact_screen.dart';
import '../quote/view/screens/quote_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildNavigationCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget screen,
    Color gradientStart,
    Color gradientEnd,
    int index,
  ) {
    return FadeInUp(
      delay: Duration(milliseconds: 150 * index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientStart.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      screen,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: animation.drive(
                            Tween(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ),
                          ),
                          child: child,
                        );
                      },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, size: 32, color: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white.withOpacity(0.8),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
              Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              FadeInDown(
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        'Multi API - Quotes',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Discover daily advice, quotes, and cat facts',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildNavigationCard(
                        context,
                        'Daily Advice',
                        'Get wisdom for your day',
                        Icons.lightbulb_outline,
                        const AdviceScreen(),
                        const Color(0xFF6366F1),
                        const Color(0xFF8B5CF6),
                        0,
                      ),
                      _buildNavigationCard(
                        context,
                        'Random Quotes',
                        'Inspire yourself with quotes',
                        Icons.format_quote,
                        const QuoteScreen(),
                        const Color(0xFF10B981),
                        const Color(0xFF059669),
                        1,
                      ),
                      _buildNavigationCard(
                        context,
                        'Cat Facts',
                        'Learn something about cats',
                        Icons.pets,
                        const CatFactScreen(),
                        const Color(0xFFF59E0B),
                        const Color(0xFFEF4444),
                        2,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
