import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/settings/settings_bloc.dart';
import '../blocs/settings/settings_event.dart';
import '../blocs/settings/settings_state.dart';

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