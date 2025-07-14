import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/network/dio_data/quote_service.dart';
import '../../data_models/Quote_model.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final QuoteService _quoteService;

  QuoteCubit(this._quoteService) : super(const QuoteInitial()) {
    print(
      "QUOTE CUBIT: Initialized with $_quoteService. Initial state: $state",
    );
  }

  Future<void> fetchQuote() async {
    print("QUOTE CUBIT: fetchQuote() called. Current state: $state");
    emit(const QuoteLoading());
    print("QUOTE CUBIT: Emitted QuoteLoading. New state: $state");
    try {
      print("QUOTE CUBIT: Calling _quoteService.getRandomQuote()");
      final quoteModel = await _quoteService.getRandomQuote();
      print(
        "QUOTE CUBIT: Quote fetched successfully: '${quoteModel.content}' by ${quoteModel.author}",
      );
      emit(QuoteLoaded(quoteModel));
      print("QUOTE CUBIT: Emitted QuoteLoaded. New state: $state");
    } catch (e) {
      final errorMessage = e
          .toString()
          .replaceFirst('Exception: ', '')
          .replaceFirst('FormatException: ', '');
      print("QUOTE CUBIT: Error fetching quote: $errorMessage");
      emit(QuoteError(errorMessage));
      print("QUOTE CUBIT: Emitted QuoteError. New state: $state");
    }
  }
}
