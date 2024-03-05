import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hayaah_karimuh/empolyer/data/dio_requests_arguments.dart';
import 'package:hayaah_karimuh/empolyer/enums/filter_enum.dart';
import 'package:hayaah_karimuh/empolyer/models/uploaded_file.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';
import 'package:hayaah_karimuh/empolyer/providers/inspections_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/filter_dialog.dart';
import 'package:hayaah_karimuh/empolyer/screens/select_address_screen.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/echo.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/empolyer/utils/text.dart';
import 'package:hayaah_karimuh/empolyer/widgets/app_buttons.dart';
import 'package:hayaah_karimuh/empolyer/widgets/custom_text_field.dart';
import 'package:hayaah_karimuh/empolyer/widgets/date_picker.dart';
import 'package:hayaah_karimuh/empolyer/widgets/files_picker.dart';
import 'package:hayaah_karimuh/empolyer/widgets/images_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

Future<void> previewBottomSheet(BuildContext context, User currentUser) async {
  final TextEditingController _inspectionAddressController = TextEditingController();
  final TextEditingController _inspectionNameController = TextEditingController();
  final TextEditingController _inspectionDateController = TextEditingController();
  final TextEditingController _inspectionNoteController = TextEditingController();
  List<UploadedFile> images = [];
  List<UploadedFile> documents = [];
  LatLng location = const LatLng(30.0444, 31.2357);
  bool loading = false;

  await showModalBottomSheet(
      enableDrag: false,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        _inspectionDateController.text = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
        InspectionsProvider _inspectionsProvider = Provider.of<InspectionsProvider>(context, listen: false);
        return StatefulBuilder(
          builder: (context, setState) {
            kEcho('project name ${_inspectionsProvider.projectsList?.name}');
            return SizedBox(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(44), topRight: Radius.circular(44))),
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height * .8,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText("اسم المشروع", bold: true).header(),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            await _showFilterDialog(
                              context,
                              type: Filter.projectsList,
                              queries: {
                                'beneficiary_type_id': _inspectionsProvider.projectsList != null ? _inspectionsProvider.projectsList!.id : '',
                                'search': _inspectionsProvider.query ?? '',
                              },
                            ).then((value) {
                              kEcho100('then called');
                              setState(() {});
                            });
                            kEcho100('after await called');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .7,
                                  child: AppText(
                                    // ignore: unnecessary_null_comparison
                                    _inspectionsProvider.projectsList != null ? _inspectionsProvider.projectsList!.name! : "اسم المشروع",
                                    maxLines: 3,
                                    color: AppColors.primaryColor,
                                    align: TextAlign.start,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  (Icons.keyboard_arrow_down),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const AppText("اسم المعاينة", bold: true).header(),
                        const SizedBox(height: 10),
                        CustomTextField(
                          //  height: 41,
                          controller: _inspectionNameController,
                          textInputType: TextInputType.text,
                          fillColor: const Color(0xFFECECEC),
                          maxLine: 1,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          "اسم المعاين",
                          style: GoogleFonts.cairo(
                            color: const Color(0xff4d4d4d),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          //  height: 41,
                          readOnly: true,
                          hintText: currentUser.name!,
                          textInputType: TextInputType.text,
                          fillColor: const Color(0xFFECECEC),
                          maxLine: 1,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const AppText("تاريخ المعاينة", bold: true).header(),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            String date = await selectDate(context);
                            _inspectionDateController.text = date;
                            setState(() {});
                          },
                          child: CustomTextField(
                            hintText: intl.DateFormat('yyyy-MM-dd').format(DateTime.now()),
                            //  height: 41,
                            enabled: false,
                            controller: _inspectionDateController,
                            textInputType: TextInputType.text,
                            fillColor: const Color(0xFFECECEC),
                            maxLine: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const AppText("اضف مكان المعاينة", bold: true).header(),
                        const SizedBox(height: 10),
                        CustomTextField(
                          //  height: 41,
                          fillColor: const Color(0xFFECECEC),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              location = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const SelectAddressScreen(),
                                ),
                              );
                              kEcho100('Selected Address -> Lat: ${location.latitude} - Lng: ${location.longitude}');
                              List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
                              Placemark place = placemarks[0];
                              kEcho100('${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}');
                              _inspectionAddressController.text = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                            },
                            icon: const Icon(
                              Icons.location_on_sharp,
                              size: 24,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          readOnly: true,
                          controller: _inspectionAddressController,
                          onTap: () async {
                            location = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SelectAddressScreen(),
                              ),
                            );
                            List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
                            Placemark place = placemarks[0];
                            _inspectionAddressController.text = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                          },
                          textInputAction: TextInputAction.done,
                          // isValidator: true,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const AppText("اضف صورة", bold: true).header(),
                        const SizedBox(height: 10),
                        imagesPicker(
                            context: context,
                            images: images,
                            refresh: () {
                              setState(() {});
                            }),
                        CustomTextField(
                          //  height: 41,
                          fillColor: const Color(0xFFECECEC),
                          prefixIcon: SvgPicture.asset(
                            SvgImages.image,
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.image);

                              if (result != null) {
                                setState(() {
                                  images.addAll(result.paths.map((path) => UploadedFile(localPath: path!)).toList());
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              size: 24,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.image);

                            if (result != null) {
                              setState(() {
                                images.addAll(result.paths.map((path) => UploadedFile(localPath: path!)).toList());
                              });
                            }
                          },
                          textInputAction: TextInputAction.done,
                          // isValidator: true,
                        ),
                        const SizedBox(height: 14),
                        const AppText("اضف ملفات", bold: true).header(),
                        const SizedBox(height: 10),
                        filesPicker(
                            context: context,
                            images: documents,
                            refresh: () {
                              setState(() {});
                            }),
                        const SizedBox(height: 4),
                        CustomTextField(
                          //  height: 41,
                          fillColor: const Color(0xFFECECEC),
                          prefixIcon: SvgPicture.asset(
                            SvgImages.attach,
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.any);

                              if (result != null) {
                                setState(() {
                                  documents.addAll(result.paths.map((path) => UploadedFile(localPath: path!)).toList());
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              size: 24,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.any);

                            if (result != null) {
                              setState(() {
                                documents.addAll(result.paths.map((path) => UploadedFile(localPath: path!)).toList());
                              });
                            }
                          },
                          textInputAction: TextInputAction.done,
                          // isValidator: true,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const AppText("اضف ملاحظات", bold: true).header(),
                        const SizedBox(height: 10),
                        CustomTextField(
                          //  height: 41,
                          controller: _inspectionNoteController,
                          textInputType: TextInputType.text,
                          fillColor: const Color(0xFFECECEC),
                          maxLine: 1,
                        ),
                        const SizedBox(height: 27),
                        kButton("اضف", loading: loading, radius: 4, func: () async {
                          if (_inspectionsProvider.projectsList == null) {
                            Fluttertoast.showToast(msg: 'يرجي اختيار اسم المشروع');
                            return;
                          }
                          loading = true;
                          setState(() {});
                          PreviewParams params = PreviewParams(
                            latitude: location.latitude.toString(),
                            longitude: location.longitude.toString(),
                            name: currentUser.id.toString(),
                            note: _inspectionNoteController.text.toString(),
                            previewDate: _inspectionDateController.text,
                            previewerId: '',
                            projectId: _inspectionsProvider.projectsList!.id.toString(),
                            images: images,
                            documents: documents,
                          );
                          await _addInspection(context, params);
                          loading = false;
                          setState(() {});
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      });
}

Future<void> _addInspection(BuildContext context, PreviewParams params) async {
  Map<String, dynamic> data = <String, dynamic>{};

  data['name'] = params.name;
  data['project_id'] = params.projectId;
  // data['previewer_id'] = params.previewerId;
  data['preview_date'] = params.previewDate;
  data['latitude'] = params.latitude;
  data['longitude'] = params.longitude;
  data['note'] = params.note;

  if (params.images.isNotEmpty) {
    for (int i = 0; i < params.images.length; i++) {
      if (params.images[i].localPath != null) {
        data['images[]'] = await MultipartFile.fromFile(params.images[i].localPath!, filename: params.images[i].localPath!.split('/').last);
      }
      kEcho('images ${params.images.length}');
    }
  }
  if (params.documents.isNotEmpty) {
    for (int i = 0; i < params.documents.length; i++) {
      if (params.documents[i].localPath != null) {
        data['documentations[]'] = await MultipartFile.fromFile(params.documents[i].localPath!, filename: params.documents[i].localPath!.split('/').last);
      }
    }
  }
  try {
    data.forEach((key, value) {
      kEcho('item $key : $value');
    });
    bool status = await networkAddInspection(data);
    Fluttertoast.showToast(msg: 'تم إنشاء مراجعة المشاريع بنجاح');
    Navigator.of(context).pop();
  } catch (e) {
    Fluttertoast.showToast(msg: '$e');
  }
}

Future<void> _showFilterDialog(BuildContext context, {required Filter type, Map<String, dynamic>? queries}) async {
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => FilterDialog(
        filterType: type,
        queries: queries,
      ),
    ),
  );
}

class PreviewParams {
  String? name;
  String? projectId;
  String? previewerId;
  String? previewDate;
  String? latitude;
  String? longitude;
  String? note;
  List<UploadedFile> images;
  List<UploadedFile> documents;
  PreviewParams({
    this.name,
    this.projectId,
    this.previewerId,
    this.previewDate,
    this.latitude,
    this.longitude,
    this.note,
    this.images = const [],
    this.documents = const [],
  });
}
