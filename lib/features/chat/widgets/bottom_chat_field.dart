import 'dart:io';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:iconsax/iconsax.dart';
import 'package:originner/colors.dart';
import 'package:originner/common/enums/message_enum.dart';
import 'package:originner/common/providers/message_reply_provider.dart';
import 'package:originner/common/utils/utils.dart';
import 'package:originner/features/chat/controller/chat_controller.dart';
import 'package:originner/features/chat/widgets/message_reply_preview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;

  const BottomChatField({
    Key? key,
    required this.recieverUserId,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;

  final TextEditingController _messageController = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed!');
    }
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.recieverUserId,
          );
      setState(() {
        _messageController.text = '';
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _soundRecorder!.stopRecorder();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await _soundRecorder!.startRecorder(
          toFile: path,
        );
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.recieverUserId,
          messageEnum,
        );
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  void selectGIF() async {
    final gif = await pickGIF(context);
    if (gif != null) {
      ref.read(chatControllerProvider).sendGIFMessage(
            context,
            gif.url,
            widget.recieverUserId,
          );
    }
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        // const Divider(color: greyColor, indent: 0,height: 8, thickness: 1,),
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 2,
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      BootstrapIcons.image,
                      color: buttonColor,
                      size: 25,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 1,
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  child: IconButton(
                    onPressed: selectVideo,
                    icon: const Icon(
                      Iconsax.menu,
                      color: buttonColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  controller: _messageController,
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    } else {
                      setState(() {
                        isShowSendButton = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 81, 81, 81),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(1),
                      child: SizedBox(
                        width: 50,
                        child: Row(
                          children: [
                            // IconButton(
                            //   onPressed: toggleEmojiKeyboardContainer,
                            //   icon: const Icon(
                            //     Iconsax.emoji_happy5,
                            //     color: Colors.grey,
                            //   ),
                            // ),
                            IconButton(
                              onPressed: selectGIF,
                              icon: const Icon(
                                BootstrapIcons.filetype_gif,
                                color: buttonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // suffixIcon: SizedBox(
                    //   width: 100,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    // IconButton(
                    //   onPressed: selectImage,
                    //   icon: const Icon(
                    //     BootstrapIcons.image_alt,
                    //     color: blackColor,
                    //     size: 25,
                    //   ),
                    // ),
                    // IconButton(
                    //   onPressed: selectVideo,
                    //   icon: const Icon(
                    //     BootstrapIcons.three_dots,
                    //     color: blackColor,
                    //   ),
                    // ),
                    //     ],
                    //   ),
                    // ),
                    hintText: 'Nhập tin nhắn ...',
                    hintStyle: const TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          width: 1, color: Color.fromARGB(255, 81, 81, 81)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          width: 1, color: Color.fromARGB(255, 81, 81, 81)),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 2,
                ),
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  radius: 25,
                  child: GestureDetector(
                    child: Icon(
                      isShowSendButton
                          ? BootstrapIcons.send_fill
                          : isRecording
                              ? BootstrapIcons.x_lg
                              : BootstrapIcons.mic,
                      color: iconColor,
                      size: 20,
                    ),
                    onTap: sendTextMessage,
                  ),
                ),
              ),
              isShowEmojiContainer
                  ? SizedBox(
                      height: 210,
                      child: EmojiPicker(
                        onEmojiSelected: ((category, emoji) {
                          setState(() {
                            _messageController.text =
                                _messageController.text + emoji.emoji;
                          });

                          if (!isShowSendButton) {
                            setState(() {
                              isShowSendButton = true;
                            });
                          }
                        }),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
