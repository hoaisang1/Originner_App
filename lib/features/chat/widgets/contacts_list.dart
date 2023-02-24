import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:originner/colors.dart';
import 'package:originner/common/widgets/loader.dart';
import 'package:originner/features/chat/controller/chat_controller.dart';
import 'package:originner/features/chat/screens/mobile_chat_screen.dart';
import 'package:originner/models/chat_contact.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: StreamBuilder<List<ChatContact>>(
          stream: ref.watch(chatControllerProvider).chatContacts(),
          builder: (contex, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var chatContactData = snapshot.data![index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MobileChatScreen.routeName,
                          arguments: {
                            'name': chatContactData.name,
                            'uid': chatContactData.contactId,
                            'profilePic': chatContactData.profilePic,
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          title: Text(
                            chatContactData.name,
                            style: const TextStyle(
                              fontSize: 18,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              chatContactData.lastMessage,
                              style: const TextStyle(
                                fontSize: 13,
                                color: greyColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              chatContactData.profilePic,
                            ),
                            radius: 30,
                          ),
                          trailing: Text(
                            DateFormat.Hm().format(chatContactData.timeSent),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}
