import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_brian_app/core/constants/app_assets.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';
import 'package:nova_brian_app/core/routes/routes.dart';
import 'package:nova_brian_app/features/home/logic/cubit/chat_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.settingsRoute,
                    arguments: context.read<ChatCubit>().userData);
              },
              icon: Icon(
                Icons.settings,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ]),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is UpdateChatErrorState) {
            context.showSnackBar(state.error);
          }
        },
        builder: (context, state) {
          if (state is GetUserDataLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                DashChat(
                  messageOptions: MessageOptions(
                    // another user chat bubble color
                    containerColor: context.isDarkMode
                        ? Colors.grey.withOpacity(0.8)
                        : Colors.white.withOpacity(0.8),
                    // user chat bubble color
                    currentUserTextColor: Colors.white,
                    textColor: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                  inputOptions: InputOptions(trailing: [
                    IconButton(
                      onPressed: () {
                        context.read<ChatCubit>().sendMediaMessage();
                      },
                      icon: const Icon(Icons.image),
                    )
                  ]),
                  currentUser: context.read<ChatCubit>().currentUser!,
                  onSend: context.read<ChatCubit>().sendMessage,
                  messages: context.read<ChatCubit>().messages,
                ),
                if (context.read<ChatCubit>().messages.isEmpty)
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(AppAssets.logo),
                  ),
                if (state is UpdateChatLoadingState)
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 4),
                      child: LinearProgressIndicator(),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
