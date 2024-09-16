import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nova_brian_app/features/auth/data/models/login/login_request_model.dart';
import 'package:nova_brian_app/features/auth/data/repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(LoginInitial());
  final AuthRepository _authRepository;
  bool isObscure = true;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void changeVisibility() {
    isObscure = !isObscure;
    emit(ChangeVisibilityState());
  }

  Future<void> login() async {
    emit(LoginLoadingState());
    final loginRequestBody = LoginRequestBody(
      email: emailController.text,
      password: passwordController.text,
    );
    final response = await _authRepository.signIn(body: loginRequestBody);
    response.fold(
      (error) {
        Logger().d(error);
        emit(LoginErrorState(error: error));
      },
      (userCredential) {
        emit(LoginSuccessState());
      },
    );
  }
}
