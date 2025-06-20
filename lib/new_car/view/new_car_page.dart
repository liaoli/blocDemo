import 'package:blocdemo/new_car/bloc/new_car_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/new_car_bloc.dart';
import '../new_car_repository.dart';

class NewCarPage extends StatelessWidget {
  const NewCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => NewCarBloc(
          newCarRepository: context.read<NewCarRepository>(),
        )..add(NewCarFormLoaded()),
        child: NewCarForm(),
      ),
    );
  }
}

class NewCarForm extends StatelessWidget {
  const NewCarForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment(0, -3 / 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _BrandDropdownButton(),
            _ModelDropdownButton(),
            _YearDropdownButton(),
            _FormSubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _BrandDropdownButton extends StatelessWidget {
  const _BrandDropdownButton();

  @override
  Widget build(BuildContext context) {
    final brands = context.select((NewCarBloc bloc) => bloc.state.brands);
    final brand = context.select((NewCarBloc bloc) => bloc.state.brand);
    return Material(
      child: DropdownButton<String>(
        key: const Key('newCarForm_brand_dropdownButton'),
        items: brands.isNotEmpty
            ? brands.map((brand) {
          return DropdownMenuItem(value: brand, child: Text(brand));
        }).toList()
            : const [],
        value: brand,
        hint: const Text('Select a Brand'),
        onChanged: (brand) {
          context.read<NewCarBloc>().add(NewCarBrandChanged(brand: brand));
        },
      ),
    );
  }
}

class _ModelDropdownButton extends StatelessWidget {
  const _ModelDropdownButton();

  @override
  Widget build(BuildContext context) {
    final models = context.select((NewCarBloc bloc) => bloc.state.models);
    final model = context.select((NewCarBloc bloc) => bloc.state.model);
    return Material(
      child: DropdownButton<String>(
        key: const Key('newCarForm_model_dropdownButton'),
        items: models.isNotEmpty
            ? models.map((model) {
          return DropdownMenuItem(value: model, child: Text(model));
        }).toList()
            : const [],
        value: model,
        hint: const Text('Select a Model'),
        onChanged: (model) {
          context.read<NewCarBloc>().add(NewCarModelChanged(model: model));
        },
      ),
    );
  }
}


class _YearDropdownButton extends StatelessWidget {
  const _YearDropdownButton();

  @override
  Widget build(BuildContext context) {
    final years = context.select((NewCarBloc bloc) => bloc.state.years);
    final year = context.select((NewCarBloc bloc) => bloc.state.year);
    return Material(
      child: DropdownButton<String>(
        key: const Key('newCarForm_year_dropdownButton'),
        items: years.isNotEmpty
            ? years.map((year) {
          return DropdownMenuItem(value: year, child: Text(year));
        }).toList()
            : const [],
        value: year,
        hint: const Text('Select a Year'),
        onChanged: (year) {
          context.read<NewCarBloc>().add(NewCarYearChanged(year: year));
        },
      ),
    );
  }
}

class _FormSubmitButton extends StatelessWidget {
  const _FormSubmitButton();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NewCarBloc>().state;

    void onFormSubmitted() {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content:
            Text('Submitted ${state.brand} ${state.model} ${state.year}'),
          ),
        );
    }

    return ElevatedButton(
      onPressed: state.isComplete ? onFormSubmitted : null,
      child: const Text('Submit'),
    );
  }
}