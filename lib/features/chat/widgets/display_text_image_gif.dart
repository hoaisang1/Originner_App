import 'package:audioplayers/audioplayers.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:originner/colors.dart';
import 'package:originner/common/enums/message_enum.dart';
import 'package:originner/features/chat/widgets/video_player_item.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;
  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();
    // ignore: avoid_print
    print(message);
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          )
        : type == MessageEnum.audio
            ? StatefulBuilder(builder: (context, setState) {
                return IconButton(
                  constraints: const BoxConstraints(
                    minWidth: 70,
                    // maxHeight: 20
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      await audioPlayer.play(UrlSource(message));
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  
                  icon: Icon(
                    isPlaying ? BootstrapIcons.pause : 
                    BootstrapIcons.play,
                  ),
                );
              })
        : type == MessageEnum.video
            ? VideoPlayerItem(
                videoUrl: message,
              )
            : type == MessageEnum.gif
                ? CachedNetworkImage(
                    imageUrl: message,
                  )
                : CachedNetworkImage(
                    imageUrl: message,
                  );
  
}}
