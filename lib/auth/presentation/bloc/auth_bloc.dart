import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);

    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final email = event.email;
      final password = event.password;

      if (password.length < 6 || !email.contains('@')) {
        return emit(AuthFailure(error: 'Invalid email or password'));
      }

      await Future.delayed(const Duration(seconds: 1), () {
        return emit(AuthSuccess(userId: '$email - $password'));
      });
    } catch (e) {
      return emit(AuthFailure(error: e.toString()));
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        return emit(AuthInitial());
      });
    } catch (e) {
      return emit(AuthFailure(error: e.toString()));
    }
  }
}
