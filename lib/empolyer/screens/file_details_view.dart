import 'dart:isolate';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/chat_message.dart';
import '../utils/app_colors.dart';

class FileDetailsScreen extends StatefulWidget {
  final ChatMessage chatMessage;

  const FileDetailsScreen({required this.chatMessage, Key? key})
      : super(key: key);

  @override
  State<FileDetailsScreen> createState() => _FileDetailsScreenState();
}

class _FileDetailsScreenState extends State<FileDetailsScreen> {
  final ReceivePort _port = ReceivePort();
  late TargetPlatform platform = Theme.of(context).platform;

  String? taskId;

  Future<bool> _checkPermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (platform == TargetPlatform.android &&
        androidInfo.version.sdkInt! <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    FlutterDownloader.registerCallback(downloadCallback as DownloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    print(
        'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () async {
                // EasyLoading.show();
                final hasPermission = await _checkPermission();
                if (hasPermission) {
                  final String savePath = (await getExternalStorageDirectories(
                          type: StorageDirectory.downloads))!
                      .first
                      .path;
                  taskId = await FlutterDownloader.enqueue(
                    url: widget.chatMessage.fileUrl!,
                    savedDir: savePath,
                    showNotification: false,
                    saveInPublicStorage: true,
                    // show download progress in status bar (for Android)
                    openFileFromNotification:
                        false, // click on notification to open downloaded file (for Android)
                  );
                }
              },
              child: const Padding(
                padding: EdgeInsetsDirectional.only(end: 20),
                child: Icon(Icons.download_sharp),
              ),
            ),
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: InkWell(
              onTap: () async {
                final hasPermission = await _checkPermission();
                if (hasPermission) {
                  final String savePath = (await getExternalStorageDirectories(
                          type: StorageDirectory.downloads))!
                      .first
                      .path;
                  taskId = await FlutterDownloader.enqueue(
                    url: widget.chatMessage.fileUrl!,
                    savedDir: savePath,
                    showNotification: false,
                    saveInPublicStorage: true,
                    // show download progress in status bar (for Android)
                    openFileFromNotification:
                        false, // click on notification to open downloaded file (for Android)
                  );
                }
              },
              child: Container(
                height: 140,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.5), width: 4),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.chatMessage.fileType!,
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      widget.chatMessage.fileName!,
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Text(
                      '${widget.chatMessage.fileSize} MB',
                      style: GoogleFonts.cairo(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                      textDirection: TextDirection.ltr,
                    ),
                    Text(
                      intl.DateFormat('hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              widget.chatMessage.timestamp!)),
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
