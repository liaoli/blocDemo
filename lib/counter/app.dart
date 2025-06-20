import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/counter_page.dart';
import '../new_car/new_car_repository.dart';
import '../new_car/view/new_car_page.dart';

class CounterApp extends MaterialApp {
  const CounterApp({super.key}): super(home: const CounterPage());

}

class MyApp extends StatelessWidget {
  const MyApp({required this.newCarRepository, super.key});

  final NewCarRepository newCarRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: newCarRepository,
      child: const MaterialApp(home: NewCarPage()),
    );
  }
}