import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:tikusevents/auth/repository/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';


class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository authRepository;

  AuthenticationBloc({@required this.authRepository}): assert(authRepository != null), super(AuthenticationUninitialized());

  AuthState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await authRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await authRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }

  }
}