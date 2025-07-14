import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/button/fetch_button.dart';
import '../../logic/quote_cubit.dart';
import '../widgets/quote_display.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("QUOTE SCREEN: Build method called.");
    return BlocProvider<QuoteCubit>(
      create: (context) {
        print("QUOTE SCREEN: Creating QuoteCubit.");
        try {
          return QuoteCubit(
            context.read(),
          ); // Let context.read infer QuoteService
        } catch (e) {
          print(
            "QUOTE SCREEN: CRITICAL ERROR - Failed to read QuoteService from context: $e. Check main.dart RepositoryProvider.",
          );
          rethrow;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Random Quotes',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade300, Colors.teal.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.shade50,
                Colors.teal.shade50,
                Colors.cyan.shade50,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: BlocBuilder<QuoteCubit, QuoteState>(
                      builder: (context, state) {
                        print(
                          "QUOTE SCREEN: BlocBuilder reacting to state: ${state.runtimeType}",
                        );
                        if (state is QuoteLoading) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.green.shade600,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Finding an inspiring quote...',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.7),
                                      ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is QuoteLoaded) {
                          return FadeInUp(
                            child: QuoteDisplay(quote: state.quote),
                          );
                        } else if (state is QuoteError) {
                          return QuoteDisplay(errorMessage: state.message);
                        } else if (state is QuoteInitial) {
                          return const QuoteDisplay(); // Explicit initial - will show default message
                        }
                        // Fallback
                        return const QuoteDisplay();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20.0,
                    ),
                    child: BlocBuilder<QuoteCubit, QuoteState>(
                      builder: (context, state) {
                        return FetchButton(
                          label: 'Get New Quote',
                          iconData: Icons.format_quote,
                          isLoading: state is QuoteLoading,
                          onPressed: () {
                            print(
                              "QUOTE SCREEN: 'Get New Quote' button pressed.",
                            );
                            context.read<QuoteCubit>().fetchQuote();
                          },
                        );
                      },
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
