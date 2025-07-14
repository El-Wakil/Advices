import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/button/fetch_button.dart';
import '../../../logic/cubit/advice_cubit.dart';
import '../../widgets/advice_display.dart';

class AdviceScreen extends StatelessWidget {
  const AdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("ADVICE SCREEN: Build method called.");
    return BlocProvider<AdviceCubit>(
      create: (context) {
        print("ADVICE SCREEN: Creating AdviceCubit.");
        try {
          return AdviceCubit(
            context.read(),
          ); // Let context.read infer AdviceService
        } catch (e) {
          print(
            "ADVICE SCREEN: CRITICAL ERROR - Failed to read AdviceService from context: $e. Check main.dart RepositoryProvider.",
          );
          // In a real app, you might want a fallback Cubit that just emits an error.
          // For debugging, rethrowing makes it very obvious.
          rethrow;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Daily Advice',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade300, Colors.indigo.shade300],
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
                Colors.purple.shade50,
                Colors.indigo.shade50,
                Colors.blue.shade50,
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
                    child: BlocBuilder<AdviceCubit, AdviceState>(
                      builder: (context, state) {
                        print(
                          "ADVICE SCREEN: BlocBuilder reacting to state: ${state.runtimeType}",
                        );
                        if (state is AdviceLoading) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.purple.shade600,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Getting your advice...',
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
                        } else if (state is AdviceLoaded) {
                          return FadeInLeftBig(
                            child: AdviceDisplay(
                              textToDisplay: state.advice.advice,
                            ),
                          );
                        } else if (state is AdviceError) {
                          return AdviceDisplay(
                            textToDisplay: state.message,
                            isError: true,
                          );
                        } else if (state is AdviceInitial) {
                          return const AdviceDisplay(
                            textToDisplay: "",
                          ); // Explicit initial
                        }
                        // Fallback for any unknown state (should ideally not happen)
                        return const AdviceDisplay(textToDisplay: "");
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20.0,
                    ),
                    child: BlocBuilder<AdviceCubit, AdviceState>(
                      builder: (context, state) {
                        return FetchButton(
                          label: 'Get New Advice',
                          iconData: Icons.lightbulb_outline,
                          isLoading: state is AdviceLoading,
                          onPressed: () {
                            print(
                              "ADVICE SCREEN: 'Get New Advice' button pressed.",
                            );
                            context.read<AdviceCubit>().fetchAdvice();
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
