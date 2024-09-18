part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetUserDataSuccessState extends ChatState {}

final class GetUserDataLoadingState extends ChatState {}

final class GetUserDataErrorState extends ChatState {
  final String error;

  GetUserDataErrorState({required this.error});
}

final class UpdateChatSuccessState extends ChatState {}

final class UpdateChatErrorState extends ChatState {
  final String error;
  UpdateChatErrorState({required this.error});
}

final class UpdateChatLoadingState extends ChatState {}

final class UploadImageSuccessState extends ChatState {}

final class UploadImageErrorState extends ChatState {
  final String error;

  UploadImageErrorState(this.error);
}
