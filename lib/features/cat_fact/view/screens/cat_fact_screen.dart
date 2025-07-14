import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasaye7/core/network/dio_data/cat_fact_service.dart';
import 'package:nasaye7/features/cat_fact/logic/cat_fact_cubit.dart';

import '../../../widgets/button/fetch_button.dart';
import '../display/cat_fact_display.dart';

class CatFactScreen extends StatelessWidget {
  const CatFactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatFactCubit(context.read<CatFactService>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Daily Cat Fact',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade300, Colors.amber.shade300],
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
                Colors.orange.shade50,
                Colors.amber.shade50,
                Colors.yellow.shade50,
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
                    child: BlocBuilder<CatFactCubit, CatFactState>(
                      builder: (context, state) {
                        if (state is CatFactLoading) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.orange.shade600,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Finding an interesting cat fact...',
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
                        } else if (state is CatFactLoaded) {
                          return FadeInUp(
                            child: CatFactDisplay(
                              textToDisplay: state.catFact.fact,
                            ),
                          );
                        } else if (state is CatFactError) {
                          return CatFactDisplay(
                            textToDisplay: state.message,
                            isError: true,
                          );
                        }
                        return const CatFactDisplay(textToDisplay: "");
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20.0,
                    ),
                    child: BlocBuilder<CatFactCubit, CatFactState>(
                      builder: (context, state) {
                        return FetchButton(
                          label: 'Get New Cat Fact',
                          iconData: Icons.pets,
                          isLoading: state is CatFactLoading,
                          onPressed: () {
                            context.read<CatFactCubit>().fetchCatFact();
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
