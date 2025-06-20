// user_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';


class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc(),
      child: UserView(),
    );
  }
}

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>(); // 获取 Bloc 实例

    return Scaffold(
      appBar: AppBar(title: Text('User Info')),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is UserInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () => bloc.add(FetchUser()),
                child: Text('Load User'),
              ),
            );
          } else if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${state.name}'),
                  Text('Email: ${state.email}'),
                ],
              ),
            );
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
