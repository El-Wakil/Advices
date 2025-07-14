import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/dio_data/advice_service.dart';
import '../../../data_models/advice_model.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceState> {
  final AdviceService _adviceService;

  AdviceCubit(this._adviceService) : super(const AdviceInitial()) {
    print(
      "ADVICE CUBIT: Initialized with $_adviceService. Initial state: $state",
    );
  }

  Future<void> fetchAdvice() async {
    print("ADVICE CUBIT: fetchAdvice() called. Current state: $state");
    emit(const AdviceLoading());
    print("ADVICE CUBIT: Emitted AdviceLoading. New state: $state");
    try {
      print("ADVICE CUBIT: Calling _adviceService.getRandomAdvice()");
      final adviceModel = await _adviceService.getRandomAdvice();
      print("ADVICE CUBIT: Advice fetched successfully: ${adviceModel.advice}");
      emit(AdviceLoaded(adviceModel));
      print("ADVICE CUBIT: Emitted AdviceLoaded. New state: $state");
    } catch (e) {
      final errorMessage = e
          .toString()
          .replaceFirst('Exception: ', '')
          .replaceFirst('FormatException: ', '');
      print("ADVICE CUBIT: Error fetching advice: $errorMessage");
      emit(AdviceError(errorMessage));
      print("ADVICE CUBIT: Emitted AdviceError. New state: $state");
    }
  }
}
