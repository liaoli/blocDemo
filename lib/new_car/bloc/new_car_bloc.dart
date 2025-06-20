import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../new_car_repository.dart';
import 'new_car_event.dart';
import 'new_car_state.dart';

class NewCarBloc extends Bloc<NewCarEvent, NewCarState> {
  final NewCarRepository _newCarRepository;

  NewCarBloc({required NewCarRepository newCarRepository})
      : _newCarRepository = newCarRepository,
        super(const NewCarState.initial()) {
    on<NewCarEvent>(_onEvent, transformer: sequential());
  }

  Future<void> _onEvent(NewCarEvent event, Emitter<NewCarState> emit) async {
    return switch (event) {
      final NewCarFormLoaded e => _onNewCarFormLoaded(e, emit),
      final NewCarBrandChanged e => _onNewCarBrandChanged(e, emit),
      final NewCarModelChanged e => _onNewCarModelChanged(e, emit),
      final NewCarYearChanged e => _onNewCarYearChanged(e, emit),
    };
  }

  Future<void> _onNewCarFormLoaded(
      NewCarFormLoaded e, Emitter<NewCarState> emit) async {
    emit(const NewCarState.brandsLoadInProgress());
    final brands = await _newCarRepository.fetchBrands();
    emit(NewCarState.brandsLoadSuccess(brands: brands));
  }

  Future<void> _onNewCarBrandChanged(
      NewCarBrandChanged event, Emitter<NewCarState> emit) async {
    emit(
      NewCarState.modelsLoadInProgress(
        brands: state.brands,
        brand: event.brand,
      ),
    );
    final models = await _newCarRepository.fetchModels(brand: event.brand);
    emit(
      NewCarState.modelsLoadSuccess(
        brands: state.brands,
        brand: event.brand,
        models: models,
      ),
    );
  }

  Future<void> _onNewCarModelChanged(
      NewCarModelChanged event,
      Emitter<NewCarState> emit,
      ) async {
    emit(
      NewCarState.yearsLoadInProgress(
        brands: state.brands,
        brand: state.brand,
        models: state.models,
        model: event.model,
      ),
    );
    final years = await _newCarRepository.fetchYears(
      brand: state.brand,
      model: event.model,
    );
    emit(
      NewCarState.yearsLoadSuccess(
        brands: state.brands,
        brand: state.brand,
        models: state.models,
        model: event.model,
        years: years,
      ),
    );
  }

  Future<void> _onNewCarYearChanged(
      NewCarYearChanged event,
      Emitter<NewCarState> emit,
      ) async {
    emit(state.copyWith(year: event.year));
  }
}
