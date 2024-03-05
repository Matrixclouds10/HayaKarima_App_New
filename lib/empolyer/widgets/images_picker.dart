import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hayaah_karimuh/empolyer/models/uploaded_file.dart';

Widget imagesPicker({
  required BuildContext context,
  required List<UploadedFile> images,
  required Function refresh,
}) {
  return Wrap(
    children: [
      ...images.map((element) {
        File file = File(element.localPath!);
        return Stack(
          children: [
            Container(
              width: 96,
              height: 96,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                  )),
            ),
            GestureDetector(
              onTap: () {
                images.removeWhere((e) => e == element);
                refresh();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(250),
                ),
                padding: const EdgeInsets.all(2.0),
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.redAccent,
                  size: 16,
                ),
              ),
            )
          ],
        );
      }).toList(),
    ],
  );
}
