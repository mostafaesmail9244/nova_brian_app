import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:nova_brian_app/core/constants/app_assets.dart';
import 'package:nova_brian_app/core/constants/constants.dart';
import 'package:nova_brian_app/core/constants/firebase_constnats.dart';
import 'package:nova_brian_app/core/helper/cache_helper.dart';
import 'package:nova_brian_app/features/home/data/models/user_model.dart';
import 'package:nova_brian_app/features/home/data/service/gemini_services.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._geminiService) : super(ChatInitial());
  final GeminiService _geminiService;
  UserModel? userData;
  ChatUser? currentUser;

  Future<void> getUserData() async {
    String? uId = CacheHelper.getData(key: Constants.uId);

    if (uId == null) {
      emit(GetUserDataErrorState(error: 'User ID not found in cache.'));
      return;
    }

    try {
      emit(GetUserDataLoadingState());

      final res = await FirebaseFirestore.instance
          .collection(FireBaseConstants.usersCollection)
          .doc(uId)
          .get();

      if (res.exists) {
        userData = UserModel.fromJson(res.data()!);

        // Assign values to `currentUser` using `userData`.
        currentUser = ChatUser(id: userData!.id, firstName: userData!.name);

        emit(GetUserDataSuccessState());
      } else {
        emit(GetUserDataErrorState(error: 'User data not found in Firestore.'));
      }
      Logger().i('User data: ${userData!.email}');
    } on FirebaseException catch (e) {
      emit(GetUserDataErrorState(error: e.message ?? 'Firebase error.'));
      Logger().e('Firebase error code: ${e.code}, message: ${e.message}');
    } catch (e) {
      emit(GetUserDataErrorState(error: e.toString()));
      Logger().e('Error fetching user data: $e');
    }
  }

  ChatUser geminiUser =
      ChatUser(id: '2', firstName: 'Gemini', profileImage: AppAssets.logo);
  List<ChatMessage> messages = [];
  void sendMessage(
    ChatMessage chatMessage,
  ) {
    file = null;
    messages = [chatMessage, ...messages];
    emit(UpdateChatSuccessState());
    try {
      String userMessage = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      emit(UpdateChatLoadingState());

      _geminiService.sendMessageToGemini(
        message: userMessage,
        images: images,
        onData: (event) {
          ChatMessage? lastMessage = messages.firstOrNull;
          if (lastMessage != null && lastMessage.user == geminiUser) {
            lastMessage = messages.removeAt(0);
            String response = event.content?.parts?.fold(
                    "", (previous, current) => "$previous ${current.text}") ??
                "";
            lastMessage.text += response;

            messages = [lastMessage, ...messages];
            emit(UpdateChatSuccessState());
          } else {
            String response = event.content?.parts?.fold(
                    "", (previous, current) => "$previous ${current.text}") ??
                "";
            ChatMessage message = ChatMessage(
              isMarkdown: true,
              user: geminiUser,
              createdAt: DateTime.now(),
              text: response,
            );
            messages = [message, ...messages];
            emit(UpdateChatSuccessState());
          }
        },
      );
    } catch (e) {
      emit(UpdateChatErrorState(error: e.toString()));
    }
  }

  XFile? file;

  void sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    emit(UploadImageSuccessState());
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser!,
        createdAt: DateTime.now(),
        text: "Describe this picture",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
      );
      sendMessage(chatMessage);
    }
  }
}
