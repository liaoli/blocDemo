import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/settings/settings_bloc.dart';
import 'pages/home_page.dart';

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