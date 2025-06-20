// user_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FetchUser>((event, emit) async {
      emit(UserLoading());
      await Future.delayed(Duration(seconds: 2)); // 模拟网络延迟

      try {
        // 模拟 API 成功返回
        final name = 'Alice';
        final email = 'alice@example.com';
        emit(UserLoaded(name: name, email: email));
        // throw(Error());
      } catch (e) {
        emit(UserError('Failed to fetch user'));
      }
    });
  }
}
