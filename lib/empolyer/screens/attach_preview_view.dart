import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/helpers/app_constants.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';
import 'package:hayaah_karimuh/empolyer/providers/attach_preview_provider.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class AttachPreviewScreen extends StatefulWidget {
  const AttachPreviewScreen({Key? key, required this.fileType, required this.filePath, required this.groupId}) : super(key: key);

  final int fileType;
  final String filePath;
  final String groupId;

  @override
  State<AttachPreviewScreen> createState() => _AttachPreviewScreenState();
}

class _AttachPreviewScreenState extends State<AttachPreviewScreen> {
  late User currentUser;
  late AttachPreviewProvider _attachPreviewProvider;

  Widget _showPreview(BuildContext context, int fileType) {
    if (fileType == MessageType.image) {
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.file(File(widget.filePath)),
      );
    } else if (fileType == MessageType.video) {
      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder<String>(
          future: _attachPreviewProvider.getVideoThumbnail(widget.filePath),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Image.file(File(snapshot.data!))
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      );
    } else {
      return Center(
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                path.basename(widget.filePath).substring(path.basename(widget.filePath).length - 3).toUpperCase(),
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                path.basename(widget.filePath),
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Text(
                '${((File(widget.filePath).lengthSync() / 1024) / 1024).toStringAsFixed(2)} MB',
                style: GoogleFonts.cairo(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    _attachPreviewProvider = Provider.of<AttachPreviewProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.mainBackground,
          iconTheme: Theme.of(context).iconTheme.copyWith(color: AppColors.primaryColor),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (EasyLoading.isShow) return;
            EasyLoading.show();
            await _attachPreviewProvider.uploadFile(widget.groupId, widget.filePath, widget.fileType);
            EasyLoading.dismiss();
            Navigator.of(context).pop();
          },
          child: SvgPicture.asset(SvgImages.send),
        ),
        body: _showPreview(context, widget.fileType),
      ),
    );
  }
}
