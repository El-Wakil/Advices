import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/network/dio_data/cat_fact_service.dart';
import '../../data_models/catfact_model.dart';

part 'cat_fact_state.dart';

class CatFactCubit extends Cubit<CatFactState> {
  final CatFactService _catFactService;

  CatFactCubit(this._catFactService) : super(CatFactInitial());

  Future<void> fetchCatFact() async {
    emit(CatFactLoading());
    try {
      final fact = await _catFactService.getRandomCatFact();
      emit(CatFactLoaded(fact));
    } catch (e) {
      emit(CatFactError("Failed to fetch cat fact."));
    }
  }
}
