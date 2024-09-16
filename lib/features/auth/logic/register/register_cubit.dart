import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nova_brian_app/features/auth/data/models/sign_up/sign_up_request_model.dart';
import 'package:nova_brian_app/features/auth/data/repo/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authRepository) : super(RegisterInitial());
  final AuthRepository _authRepository;
  bool isObscure = true;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  void changeVisibility() {
    isObscure = !isObscure;
    emit(ChangeVisibilityState());
  }

  Future<void> signUp() async {
    emit(RegisterLoadingState());
    final registerRequestBody = SignupRequestBody(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    final response = await _authRepository.signUp(body: registerRequestBody);
    response.fold(
      (error) {
        Logger().d(error);

        emit(RegisterErrorState(error: error));
      },
      (userCredential) {
        emit(RegisterSuccessState());
      },
    );
  }
}
