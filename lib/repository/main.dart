

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => UserRepository()),
        RepositoryProvider(create: (_) => SettingsRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc(context.read<UserRepository>()),
          ),
          BlocProvider(
            create: (context) => SettingsBloc(context.read<SettingsRepository>()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Bloc Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: context.select<SettingsBloc, bool>((bloc) => bloc.state.isDarkMode)
          ? ThemeMode.dark
          : ThemeMode.light,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multi Bloc Example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserPage(),
          Divider(),
          SettingsPage(),
        ],
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          return ElevatedButton(
            onPressed: () => context.read<UserBloc>().add(FetchUser()),
            child: Text("Load User"),
          );
        } else if (state is UserLoading) {
          return CircularProgressIndicator();
        } else if (state is UserLoaded) {
          return Text('Hello, ${state.name}');
        } else {
          return Text('Something went wrong');
        }
      },
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return SwitchListTile(
          title: Text('Dark Mode'),
          value: state.isDarkMode,
          onChanged: (_) => context.read<SettingsBloc>().add(ToggleTheme()),
        );
      },
    );
  }
}

// repositories/user_repository.dart
class UserRepository {
  Future<String> fetchUserName() async {
    await Future.delayed(Duration(seconds: 1));
    return 'Alice';
  }
}

// repositories/settings_repository.dart
class SettingsRepository {
  bool _darkMode = false;

  bool get isDarkMode => _darkMode;
  void toggleDarkMode() => _darkMode = !_darkMode;
}

// blocs/user/user_event.dart
abstract class UserEvent {}

class FetchUser extends UserEvent {}

// blocs/user/user_state.dart
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final String name;
  UserLoaded(this.name);
}

// blocs/user/user_bloc.dart
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUser>((event, emit) async {
      emit(UserLoading());
      final name = await userRepository.fetchUserName();
      emit(UserLoaded(name));
    });
  }
}

// blocs/settings/settings_event.dart
abstract class SettingsEvent {}

class ToggleTheme extends SettingsEvent {}

// blocs/settings/settings_state.dart
class SettingsState {
  final bool isDarkMode;
  SettingsState(this.isDarkMode);
}

// blocs/settings/settings_bloc.dart
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  SettingsBloc(this.repository) : super(SettingsState(repository.isDarkMode)) {
    on<ToggleTheme>((event, emit) {
      repository.toggleDarkMode();
      emit(SettingsState(repository.isDarkMode));
    });
  }
}
