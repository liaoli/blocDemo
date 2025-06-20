import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/user_repository.dart';
import 'repositories/settings_repository.dart';
import 'blocs/user/user_bloc.dart';
import 'blocs/settings/settings_bloc.dart';

class AppProviderWrapper extends StatelessWidget {
  final Widget child;
  const AppProviderWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
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
        child: child,
      ),
    );
  }
}