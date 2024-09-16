import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nova_brian_app/features/auth/data/repo/auth_repo.dart';

part 'forget_pass_state.dart';

class ForgetPassCubit extends Cubit<ForgetPassState> {
  ForgetPassCubit(this._authRepository) : super(ForgetPassInitial());
  final AuthRepository _authRepository;
  final formKey = GlobalKey<FormState>();
  TextEditingController forgetPassController = TextEditingController();

  Future<void> forgetPassword() async {
    emit(ForgetPassLoadingState());
    final response = await _authRepository.forgetPassword(
      email: forgetPassController.text,
    );
    response.fold(
      (error) {
        Logger().d(error);

        emit(ForgetPassErrorState(error: error));
      },
      (success) {
        emit(ForgetPassSuccessState());
      },
    );
  }
}
