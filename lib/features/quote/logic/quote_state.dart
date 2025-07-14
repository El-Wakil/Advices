part of 'quote_cubit.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object?> get props => [];
}

class QuoteInitial extends QuoteState {
  const QuoteInitial();
  @override
  String toString() => 'QuoteInitial';
}

class QuoteLoading extends QuoteState {
  const QuoteLoading();
  @override
  String toString() => 'QuoteLoading';
}

class QuoteLoaded extends QuoteState {
  final QuoteModel quote;

  const QuoteLoaded(this.quote);

  @override
  List<Object?> get props => [quote];

  @override
  String toString() =>
      'QuoteLoaded(quote: "${quote.content.substring(0, (quote.content.length > 20) ? 20 : quote.content.length)}...")';
}

class QuoteError extends QuoteState {
  final String message;

  const QuoteError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'QuoteError(message: "$message")';
}
