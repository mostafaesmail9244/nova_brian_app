import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_brian_app/core/constants/app_assets.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';
import 'package:nova_brian_app/core/theme/app_colors.dart';
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
                  messageOptions:
                      const MessageOptions(containerColor: AppColors.grey),
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
                    alignment: Alignment.bottomCenter, // Position at the bottom
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
