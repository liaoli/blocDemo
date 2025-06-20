import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';
import '../../repositories/settings_repository.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  SettingsBloc(this.repository) : super(SettingsState(repository.isDarkMode)) {
    on<ToggleTheme>((event, emit) {
      repository.toggleDarkMode();
      emit(SettingsState(repository.isDarkMode));
    });
  }
}