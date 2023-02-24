import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:originner/colors.dart';
import 'package:originner/common/providers/message_reply_provider.dart';
import 'package:originner/features/chat/widgets/display_text_image_gif.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({Key? key}) : super(key: key);

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageReplyProvider);

    return Container(
      width: 350,
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  messageReply!.isMe
                      ? 'Đang trả lời chính mình'
                      : 'Đang trả lời đối phương',
                  style: const TextStyle(
                    color: greyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Padding(
                // padding: const EdgeInsets.all(8.0),
                // child: 
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 81, 81, 81),
                  radius: 25,
                  child: GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.only(),
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: textColor,
                      ),
                    ),
                    onTap: () => cancelReply(ref),
                  ),
                ),
              // ),
            ],
          ),
          // const SizedBox(height: 0),
          DisplayTextImageGIF(
            message: messageReply.message,
            type: messageReply.messageEnum,
          ),
           const SizedBox(height: 15),
        ],
      ),
    );
  }
}
