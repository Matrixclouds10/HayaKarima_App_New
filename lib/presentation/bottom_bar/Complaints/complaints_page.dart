import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc/bloc_complain/complain_bloc.dart';
import '../../../bloc/country_list/flight_country_list_bloc.dart';
import '../../../bloc/idea_area/idea_area_bloc.dart';
import '../../../constants/my_colors.dart';
import '../../../data/model/model_complain.dart';
import '../../../generated/locale_keys.g.dart';
import '../../widgets/Widget_DropdownMenu.dart';
import '../../widgets/Widget_DropdownMenu_Idea.dart';
import '../../widgets/_EmailInput.dart';
import '../../widgets/_imgInput.dart';
import '../../widgets/_nameInput.dart';
import '../../widgets/_numberInput.dart';
import '../../widgets/button.dart';
import '../../widgets/customAlertDialoge.dart';
import '../../widgets/myNaviagtor.dart';
import '../Bottom_Bar_Screen.dart';

enum SingingCharacter { suggestion, complaint }

class complaints_page extends StatefulWidget {
  @override
  _complaints_page createState() => _complaints_page();
}

class _complaints_page extends State<complaints_page> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late var email, password;
  TextEditingController textEditingController_name = TextEditingController();
  TextEditingController textEditingController_nationality = TextEditingController();
  TextEditingController textEditingController_nationality_num = TextEditingController();

  TextEditingController textEditingController_mobile = TextEditingController();
  TextEditingController textEditingController_img = TextEditingController();
  TextEditingController textEditingController_suggestion = TextEditingController();
  // late ProgressDialog pr;

  TextEditingController textEditingController_email = TextEditingController();
  TextEditingController textEditingController_password = TextEditingController();
  SingingCharacter? select = SingingCharacter.suggestion;
  var tittle = LocaleKeys.suggestion.tr();
  XFile? image;
  late var nationalityid, idear_area;

  @override
  void initState() {
    // TODO: implement initState

    context.read<CountryListBloc>().add(const Submission_CountryEvent());
    context.read<IdeaAreaBloc>().add(const Submission_IdeaEvent());
    // pr = ProgressDialog(context, showLogs: true);
    // pr.style(message: 'Please wait...');

    super.initState();
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return ListView(
      children: <Widget>[
        Form(
            key: globalFormKey,
            child: Column(children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
                child: Text(
                  LocaleKeys.Complaints_and_suggestions.tr(),
                  style: TextStyle(fontSize: 22.sp, color: HexColor(MyColors.green), fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
                child: NameInput(
                  icon: null,

                  // Icon(
                  //   Icons.person,
                  //   color: HexColor(MyColors.green),
                  // ),
                  textEditingController: textEditingController_name,
                  validation_Message: LocaleKeys.Please_write_the_name.tr(),
                  onSaved: (val) {},
                  maxLines: 1,
                  onChanged: (val) {},
                  hintText: LocaleKeys.fname.tr(),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
                child: EmailInput(
                  textEditingController: textEditingController_email,
                  onSaved: (val) {},
                  onChanged: (val) {},
                  hintText: LocaleKeys.mail.tr(),
                  prefixIcon: null,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.h, left: 20.w, right: 20.w),
                width: double.infinity,
                child: Widget_DropdownMenu(
                  onChanged: (val) {
                    nationalityid = val.id;
                  },
                  onSaved: (val) {},
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
                child: NumberInput(
                  icon: null,

                  // Icon(
                  //   Icons.phone_android,
                  //   color: HexColor(MyColors.green),
                  // ),
                  textEditingController: textEditingController_mobile,
                  validator: (value) => value!.isEmpty
                      ? LocaleKeys.phone_valid.tr()
                      : textEditingController_mobile.text.length > 10
                          ? null
                          : LocaleKeys.phone_valid.tr(),
                  onSaved: (val) {},
                  maxLines: 1,
                  onChanged: (val) {},
                  hintText: LocaleKeys.mobile.tr(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
                child: NumberInput(
                  icon: null,
                  // Icon(
                  //   Icons.credit_card,
                  //   color: HexColor(MyColors.green),
                  // ),
                  textEditingController: textEditingController_nationality_num,
                  validator: (value) => value!.isEmpty
                      ? LocaleKeys.national_num.tr()
                      : textEditingController_nationality_num.text.length > 13
                          ? null
                          : LocaleKeys.national_num.tr(),
                  onSaved: (val) {},
                  maxLines: 1,
                  onChanged: (val) {},
                  hintText: LocaleKeys.National_ID.tr(),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
                child: ImgInput(
                  icon: Icon(
                    Icons.image,
                    color: HexColor(MyColors.gray),
                  ),
                  textEditingController: textEditingController_img,
                  validation_Message: '',
                  onSaved: (val) {},
                  maxLines: 1,
                  onChanged: (val) {},
                  hintText: LocaleKeys.card_image.tr(),
                  onTap: () async {
                    var imageUri = await ImagePicker.platform.getImage(source: ImageSource.gallery);

                    setState(() {
                      textEditingController_img.text = imageUri!.path;
                    });
                  },
                  prefixIcon: null,
                ),
              ),

              // Container(
              //   width: width,
              //   margin: EdgeInsets.only(top: 10.h),
              //   child: Column(
              //     children: <Widget>[
              //       ListTile(
              //         title: Text("${LocaleKeys.suggestion.tr()}"),
              //         leading: Radio<SingingCharacter>(
              //             value: SingingCharacter.suggestion,
              //             groupValue: select,
              //             activeColor: HexColor(MyColors.green),
              //             onChanged: (SingingCharacter? value) {
              //               setState(() {
              //                 select = value;
              //                 tittle = "${LocaleKeys.suggestion.tr()}";
              //               });
              //             }),
              //       ),
              //       ListTile(
              //         title: Text("${LocaleKeys.complaint.tr()}"),
              //         leading: Radio<SingingCharacter>(
              //             value: SingingCharacter.complaint,
              //             groupValue: select,
              //             activeColor: HexColor(MyColors.green),
              //             onChanged: (SingingCharacter? value) {
              //               setState(() {
              //                 select = value;
              //                 tittle = "${LocaleKeys.complaint.tr()}";
              //                 print("----->onChanged $select");
              //               });
              //             }),
              //       )
              //     ],
              //   ),
              // ),

              Container(
                  child: Row(
                children: <Widget>[
                  SizedBox(
                    width: width / 2.1,
                    child: ListTile(
                      title: Text(LocaleKeys.suggestion.tr()),
                      dense: true,
                      leading: Radio<SingingCharacter>(
                          value: SingingCharacter.suggestion,
                          groupValue: select,
                          activeColor: HexColor(MyColors.black),
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              select = value;
                              tittle = LocaleKeys.suggestion.tr();
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    width: width / 2.2,
                    child: ListTile(
                      title: Text(LocaleKeys.complaint.tr()),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Radio<SingingCharacter>(
                          value: SingingCharacter.complaint,
                          groupValue: select,
                          activeColor: HexColor(MyColors.black),
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              select = value;
                              tittle = LocaleKeys.complaint.tr();
                              print("----->onChanged $select");
                            });
                          }),
                    ),
                  )
                ],
              )),

              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h, bottom: 10.h),
                child: Text(
                  LocaleKeys.Choose_field.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: HexColor(MyColors.green),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.h, left: 20.w, right: 20.w),
                width: double.infinity,
                child: Widget_DropdownMenu_Idea(
                  onChanged: (val) {
                    idear_area = val.id;

                    print("----->Widget_DropdownMenu_Idea : $idear_area");
                  },
                  onSaved: (val) {},
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
                child: Text(
                  tittle,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: HexColor(MyColors.green),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              Container(
                height: 120.h,
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
                child: NameInput(
                  icon: Icon(
                    null,
                    color: HexColor(MyColors.green),
                  ),
                  textEditingController: textEditingController_suggestion,
                  validation_Message: '',
                  onSaved: (val) {},
                  maxLines: 8,
                  onChanged: (val) {},
                  hintText: "",
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
                height: 50.h,
                child: Button_Widget(
                  color_text: HexColor(MyColors.white),
                  color: HexColor(MyColors.green),
                  onTap: () async {
                    if (validateAndSave()) {
                      Complain_Post model = Complain_Post(name: textEditingController_name.text, email: textEditingController_email.text, phone: textEditingController_mobile.text, type: select == SingingCharacter.complaint ? "complaint" : "suggestion", description: textEditingController_suggestion.text, national_id_photo: textEditingController_img.text, nationality_id: textEditingController_nationality_num.text, idea_area_id: "$idear_area", country: "$nationalityid");
                      // pr.show();

                      context.read<ComplainBloc>().add(Start_ComplainEvent());
                      context.read<ComplainBloc>().add(Submission_ComplainEvent(name: model.name, phone: model.phone, type: model.type, national_id_photo: model.national_id_photo, description: model.description, nationality_id: model.nationality_id, email: model.email, idea_area_id: model.idea_area_id, country: model.country));

                      print("----->onTap  ${model.nationality_id}");
                    }
                  },
                  tittle: LocaleKeys.send.tr(),
                  fontSize: 18.sp,
                ),
              ),

              BlocListener<ComplainBloc, ComplainState>(
                listener: (context, state) {
                  if (state is Complain_Loaded_State) {
                    // pr.hide();
                    _showSnackBar(context, (state).model.message);
                    //pop up Mobark
                    showDialog(
                      barrierColor: Colors.black26,
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog(
                          title: select == SingingCharacter.complaint ? "تم ارسال الشكوي" : "تم ارسال الاقتراح",
                          image: 'assets/tha.png',
                          onBtnTap: () {
                            myNavigate(screen: Bottom_Bar_Screen(), context: context);
                          },
                          fromLogin: false,
                          btnTitle: 'العودة للرئسية',
                        );
                      },
                    );
                  } else if (state is Complain_ErrorState) {
                    // pr.hide();
                    //pop up Mobark
                    // showDialog(
                    //   barrierColor: Colors.black26,
                    //   context: context,
                    //   builder: (context) {
                    //     return CustomAlertDialog(
                    //       title: "تم ارسال الاقتراح",
                    //       image: 'assets/tha.png',
                    //       onBtnTap: () {
                    //         myNavigate(
                    //             screen: Bottom_Bar_Screen(), context: context);
                    //       },
                    //       btnTitle: 'العودة للرئيسية',
                    //     );
                    //   },
                    // );
                    _showSnackBar(context, (state).message);
                  }
                  // do stuff here based on BlocA's state
                },
                child: Container(),
              )
            ])),
      ],
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  // LoginResponse_Error loginResponse_Error=new LoginResponse_Error.fromJson(json.decode(message));
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
