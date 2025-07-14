import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/network/dio_data/advice_service.dart';
import 'core/network/dio_data/cat_fact_service.dart';
import 'core/network/dio_data/quote_service.dart';
import 'features/home_screen/home_screen.dart';

void main() {
  final adviceService = AdviceService();
  final quoteService = QuoteService();
  final catFactService = CatFactService();

  runApp(
    MyApp(
      adviceService: adviceService,
      quoteService: quoteService,
      catFactService: catFactService,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AdviceService adviceService;
  final QuoteService quoteService;
  final CatFactService catFactService;

  const MyApp({
    super.key,
    required this.adviceService,
    required this.quoteService,
    required this.catFactService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: adviceService),
        RepositoryProvider.value(value: quoteService),
        RepositoryProvider.value(value: catFactService),
      ],
      child: MaterialApp(
        title: 'Multi API - Quotes',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4),
            brightness: Brightness.light,
          ),
          cardTheme: CardThemeData(
            elevation: 4,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 6,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4),
            brightness: Brightness.dark,
          ),
          cardTheme: CardThemeData(
            elevation: 4,
            shadowColor: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 6,
              shadowColor: Colors.black54,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
