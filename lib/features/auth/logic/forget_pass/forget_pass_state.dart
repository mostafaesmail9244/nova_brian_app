part of 'forget_pass_cubit.dart';

@immutable
sealed class ForgetPassState {}

final class ForgetPassInitial extends ForgetPassState {}

final class ForgetPassLoadingState extends ForgetPassState {}

final class ForgetPassErrorState extends ForgetPassState {
  final String error;
  ForgetPassErrorState({required this.error});
}

final class ForgetPassSuccessState extends ForgetPassState {}
