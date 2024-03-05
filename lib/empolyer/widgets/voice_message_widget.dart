import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_message.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:intl/intl.dart' as intl;

class VoiceMessageWidget extends StatefulWidget {
  const VoiceMessageWidget({Key? key, required this.chatMessage}) : super(key: key);
  final ChatMessage chatMessage;

  @override
  State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget> {
  final User currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);
  final AssetsAudioPlayer player = AssetsAudioPlayer();
  bool isPlaying = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Duration _duration = Duration(milliseconds: widget.chatMessage.duration!);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
              stream: player.isPlaying,
              builder: (context, snapshot) {
                // final bool state = snapshot.data! as bool;
                return snapshot.hasData
                    ? GestureDetector(
                        onTap: () async {
                          log('OnTap Audio');
                          log('Audio Link: ${widget.chatMessage.audioUrl}');
                          if (snapshot.data! as bool) {
                            await player.stop();
                          } else {
                            await player.open(Audio.network(widget.chatMessage.audioUrl!));
                          }
                        },
                        child: Icon(
                          // _audioPlayer.state != AudioPlayerState.PLAYING
                          //     ?
                          (snapshot.data! as bool) ? Icons.stop_circle_outlined : Icons.play_circle_outline_sharp,
                          // : Icons.pause_circle_outline,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                      )
                    : const SizedBox(
                        height: 10,
                        width: 10,
                      );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Voice message',
                  style: GoogleFonts.cairo(
                    color: const Color(0xff484848),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: widget.chatMessage.senderId == currentUser.id ? TextAlign.start : TextAlign.end,
                ),
                // Text(
                //   '${_duration.inHours.remainder(60).toString()}:${_duration.inMinutes.remainder(60).toString()}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                //   style: GoogleFonts.cairo(
                //     color: const Color(0xff484848),
                //     fontSize: 13,
                //     fontWeight: FontWeight.w600,
                //     fontStyle: FontStyle.normal,
                //   ),
                //   textAlign: widget.chatMessage.senderId == currentUser.id ? TextAlign.start : TextAlign.end,
                // ),
              ],
            ),
            const Spacer(),
            Text(
              intl.DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.chatMessage.timestamp!)),
              style: GoogleFonts.cairo(
                color: const Color(0xff484848),
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
