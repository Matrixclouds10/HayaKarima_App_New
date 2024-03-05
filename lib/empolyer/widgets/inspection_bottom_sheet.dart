import 'package:flutter/material.dart';
import 'package:hayaah_karimuh/empolyer/models/project.dart';

import '../helpers/preferences_manager.dart';
import '../models/user.dart';

class InspectionBottomSheet extends StatefulWidget {
  final Project project;
  const InspectionBottomSheet({required this.project, Key? key}) : super(key: key);

  @override
  State<InspectionBottomSheet> createState() => _InspectionBottomSheetState();
}

class _InspectionBottomSheetState extends State<InspectionBottomSheet> {
  final User currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Directionality(
    //   textDirection: TextDirection.rtl,
    //   child: SingleChildScrollView(
    //     child: Container(
    //       padding: const EdgeInsets.all(24),
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(44), topRight: Radius.circular(44))),
    //       width: double.infinity,
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             "اسم المشروع",
    //             style: GoogleFonts.cairo(
    //               color: Color(0xff4d4d4d),
    //               fontSize: 16,
    //               fontWeight: FontWeight.w700,
    //               fontStyle: FontStyle.normal,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           CustomTextField(
    //             readOnly: true,
    //             hintText: widget.project.name!,
    //             height: 41,
    //             textInputType: TextInputType.text,
    //             fillColor: Color(0xFFECECEC),
    //             maxLine: 1,
    //           ),
    //           SizedBox(
    //             height: 14,
    //           ),
    //           Text(
    //             "اسم المعاينة",
    //             style: GoogleFonts.cairo(
    //               color: Color(0xff4d4d4d),
    //               fontSize: 16,
    //               fontWeight: FontWeight.w700,
    //               fontStyle: FontStyle.normal,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           CustomTextField(
    //             height: 41,
    //             textInputType: TextInputType.text,
    //             fillColor: Color(0xFFECECEC),
    //             maxLine: 1,
    //           ),
    //           SizedBox(
    //             height: 14,
    //           ),
    //           Text(
    //             "اسم المعاين",
    //             style: GoogleFonts.cairo(
    //               color: Color(0xff4d4d4d),
    //               fontSize: 16,
    //               fontWeight: FontWeight.w700,
    //               fontStyle: FontStyle.normal,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           CustomTextField(
    //             height: 41,
    //             hintText: currentUser.name!,
    //             textInputType: TextInputType.text,
    //             fillColor: Color(0xFFECECEC),
    //             maxLine: 1,
    //           ),
    //           SizedBox(
    //             height: 14,
    //           ),
    //           Text(
    //             "تاريخ المعاينة",
    //             style: GoogleFonts.cairo(
    //               color: Color(0xff4d4d4d),
    //               fontSize: 16,
    //               fontWeight: FontWeight.w700,
    //               fontStyle: FontStyle.normal,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           CustomTextField(
    //             hintText: intl.DateFormat('yyyy-MM-dd').format(DateTime.now()),
    //             height: 41,
    //             textInputType: TextInputType.text,
    //             fillColor: Color(0xFFECECEC),
    //             maxLine: 1,
    //           ),
    //           SizedBox(
    //             height: 14,
    //           ),
    //           Text(
    //             "اضف مكان المعاينة",
    //             style: GoogleFonts.cairo(
    //               color: Color(0xff4d4d4d),
    //               fontSize: 16,
    //               fontWeight: FontWeight.w700,
    //               fontStyle: FontStyle.normal,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           CustomTextField(
    //             height: 41,
    //             fillColor: Color(0xFFECECEC),
    //             // prefixIcon: SvgPicture.asset(
    //             //   SvgImages.image,
    //             //   fit: BoxFit.scaleDown,
    //             // ),
    //             suffixIcon: IconButton(
    //               onPressed: () async {
    //                 location = await Navigator.of(context).push(
    //                   MaterialPageRoute(
    //                     builder: (_) => SelectAddressScreen(),
    //                   ),
    //                 );
    //                 log('Selected Address -> Lat: ${location.latitude} - Lng: ${location.longitude}');
    //                 List<Placemark> placemarks = await placemarkFromCoordinates(
    //                     location.latitude, location.longitude);
    //                 print(placemarks);
    //                 Placemark place = placemarks[0];
    //                 log('${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}');
    //                 _addressController.text =
    //                     '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    //               },
    //               icon: const Icon(
    //                 Icons.location_on_sharp,
    //                 size: 24,
    //                 color: AppColors.primaryColor,
    //               ),
    //             ),
    //             readOnly: true,
    //             controller: _addressController,
    //             onTap: () async {
    //               location = await Navigator.of(context).push(
    //                 MaterialPageRoute(
    //                   builder: (_) => SelectAddressScreen(),
    //                 ),
    //               );
    //               log('Selected Address -> Lat: ${location.latitude} - Lng: ${location.longitude}');
    //             },
    //             textInputAction: TextInputAction.done,
    //             // isValidator: true,
    //           ),
    //           SizedBox(
    //             height: 14,
    //           ),
    //           Text(
    //             "اضف صورة",
    //             style: GoogleFonts.cairo(
    //               color: Color(0xff4d4d4d),
    //               fontSize: 16,
    //               fontWeight: FontWeight.w700,
    //               fontStyle: FontStyle.normal,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           CustomTextField(
    //             height: 41,
    //             fillColor: Color(0xFFECECEC),
    //             prefixIcon: SvgPicture.asset(
    //               SvgImages.image,
    //               fit: BoxFit.scaleDown,
    //             ),
    //             suffixIcon: IconButton(
    //               onPressed: () async {
    //                 FilePickerResult? result = await FilePicker.platform
    //                     .pickFiles(allowMultiple: true, type: FileType.image);
    //
    //                 if (result != null) {
    //                   setState(() {
    //                     images.addAll(result.paths
    //                         .map((path) => UploadedFile(localPath: path!))
    //                         .toList());
    //                   });
    //                 }
    //               },
    //               icon: const Icon(
    //                 Icons.add_circle,
    //                 size: 24,
    //                 color: AppColors.primaryColor,
    //               ),
    //             ),
    //             readOnly: true,
    //             onTap: () async {
    //               FilePickerResult? result = await FilePicker.platform
    //                   .pickFiles(allowMultiple: true, type: FileType.image);
    //
    //               if (result != null) {
    //                 setState(() {
    //                   images.addAll(result.paths
    //                       .map((path) => UploadedFile(localPath: path!))
    //                       .toList());
    //                 });
    //               }
    //             },
    //             textInputAction: TextInputAction.done,
    //             // isValidator: true,
    //           ),
    //           SizedBox(
    //             height: 14,
    //           ),
    //           Text(
    //             "اضف ملفات",
    //             style: GoogleFonts.cairo(
    //               color: Color(0xff4d4d4d),
    //               fontSize: 16,
    //               fontWeight: FontWeight.w700,
    //               fontStyle: FontStyle.normal,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           CustomTextField(
    //             prefixIcon: SvgPicture.asset(
    //               SvgImages.attach,
    //               fit: BoxFit.scaleDown,
    //             ),
    //             suffixIcon: IconButton(
    //               onPressed: () async {
    //                 FilePickerResult? result = await FilePicker.platform
    //                     .pickFiles(allowMultiple: true, type: FileType.any);
    //
    //                 if (result != null) {
    //                   setState(() {
    //                     documents.addAll(result.paths
    //                         .map((path) => UploadedFile(localPath: path!))
    //                         .toList());
    //                   });
    //                 }
    //               },
    //               icon: const Icon(
    //                 Icons.add_circle,
    //                 size: 24,
    //                 color: AppColors.primaryColor,
    //               ),
    //             ),
    //             readOnly: true,
    //             onTap: () async {
    //               FilePickerResult? result = await FilePicker.platform
    //                   .pickFiles(allowMultiple: true, type: FileType.any);
    //
    //               if (result != null) {
    //                 setState(() {
    //                   documents.addAll(result.paths
    //                       .map((path) => UploadedFile(localPath: path!))
    //                       .toList());
    //                 });
    //               }
    //             },
    //             fillColor: Colors.white,
    //             textInputAction: TextInputAction.done,
    //             // isValidator: true,
    //           ),
    //           SizedBox(
    //             height: 14,
    //           ),
    //           Text(
    //             "اضف ملاحظات",
    //             style: GoogleFonts.cairo(
    //               color: Color(0xff4d4d4d),
    //               fontSize: 16,
    //               fontWeight: FontWeight.w700,
    //               fontStyle: FontStyle.normal,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           CustomTextField(
    //             height: 41,
    //             textInputType: TextInputType.text,
    //             fillColor: Color(0xFFECECEC),
    //             maxLine: 1,
    //           ),
    //           SizedBox(
    //             height: 27,
    //           ),
    //           Container(
    //             width: double.infinity,
    //             margin:
    //                 const EdgeInsets.symmetric(horizontal: 36, vertical: 30),
    //             child: ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                   fixedSize: const Size(double.infinity, 46),
    //                   padding: EdgeInsets.zero),
    //               onPressed: () async {
    //                 // await _addInspection();
    //               },
    //               child: Text(
    //                 "اضف",
    //                 style: GoogleFonts.cairo(
    //                   color: Colors.white,
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.w700,
    //                   fontStyle: FontStyle.normal,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
