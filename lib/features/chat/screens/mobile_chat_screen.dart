// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:originner/colors.dart';
import 'package:originner/common/widgets/loader.dart';
import 'package:originner/features/auth/controller/auth_controller.dart';
import 'package:originner/features/call/controller/call_controller.dart';
import 'package:originner/features/call/screens/call_pickup_screen.dart';
import 'package:originner/features/chat/widgets/bottom_chat_field.dart';

import 'package:originner/models/user_model.dart';
import 'package:originner/features/chat/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;

  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);

  void makeCall(WidgetRef ref, BuildContext context) {
    ref.read(callControllerProvider).makeCall(
          context,
          name,
          uid,
          '',
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          foregroundColor: greyColor,
          backgroundColor: blackColor,
          title: StreamBuilder<UserModel>(
              stream: ref.read(authControllerProvider).userDataById(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w700,
                      ),
                      // textAlign: TextAlign.right
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        snapshot.data!.isOnline ? 'Online' : 'Offline',
                        style: const TextStyle(
                          fontSize: 13,
                          color: greyColor,
                          fontWeight: FontWeight.w700,
                        ),
                        // textAlign: TextAlign.right
                      ),
                    ),
                  ],
                );
              }),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => makeCall(ref, context),
              icon: const Icon(
                BootstrapIcons.camera_video,
                color: buttonColor,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                BootstrapIcons.telephone_forward,
                color: buttonColor,
                size: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                BootstrapIcons.list_task,
                color: buttonColor,
                size: 26,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(
                recieverUserId: uid,
              ),
            ),
            BottomChatField(
              recieverUserId: uid,
            ),
          ],
        ),
      ),
    );
  }
}
