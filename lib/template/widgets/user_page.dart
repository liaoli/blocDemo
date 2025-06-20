import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';

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