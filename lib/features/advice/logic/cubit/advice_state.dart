part of 'advice_cubit.dart';

abstract class AdviceState extends Equatable {
  const AdviceState();

  @override
  List<Object?> get props => [];
}

class AdviceInitial extends AdviceState {
  const AdviceInitial();
  @override
  String toString() => 'AdviceInitial';
}

class AdviceLoading extends AdviceState {
  const AdviceLoading();
  @override
  String toString() => 'AdviceLoading';
}

class AdviceLoaded extends AdviceState {
  final AdviceModel advice;

  const AdviceLoaded(this.advice);

  @override
  List<Object?> get props => [advice];

  @override
  String toString() => 'AdviceLoaded(advice: ${advice.advice})';
}

class AdviceError extends AdviceState {
  final String message;

  const AdviceError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'AdviceError(message: "$message")';
}
