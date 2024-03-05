// ignore_for_file: non_constant_identifier_names, camel_case_types, unnecessary_string_interpolations, prefer_typing_uninitialized_variables, unused_local_variable
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hayaah_karimuh/constants/my_colors.dart';
import 'package:hayaah_karimuh/data/data_source/api/services.dart';
import 'package:hayaah_karimuh/data/data_source/local/local.dart';
import 'package:hayaah_karimuh/data/echo.dart';
import 'package:hayaah_karimuh/data/model/model_cities.dart';
import 'package:hayaah_karimuh/data/model/model_governments.dart';
import 'package:hayaah_karimuh/data/repository/repository.dart';
import 'package:hayaah_karimuh/generated/locale_keys.g.dart';
import 'package:hayaah_karimuh/presentation/bottom_bar/Bottom_Bar_Screen.dart';
import 'package:hayaah_karimuh/presentation/bottom_bar/profile/profile_response.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:hayaah_karimuh/presentation/widgets/_EmailInput.dart';
import 'package:hayaah_karimuh/presentation/widgets/_passwordField.dart';
import 'package:hayaah_karimuh/presentation/widgets/button.dart';
import 'package:hayaah_karimuh/presentation/widgets/myNaviagtor.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/AuthHandel/auth_handel_bloc.dart';
import '../../../bloc/change_Image/changeImage_bloc.dart';
import '../../../bloc/cities/cities_bloc.dart';
import '../../../bloc/governments/governments_bloc.dart';
import '../../../bloc/profile/profile_bloc.dart';
import '../../../constants/strings.dart';
import '../../auth/login/login_screen.dart';
import '../../widgets/Widget_DropdownMenu_governments.dart';
import '../../widgets/_nameInput.dart';
import '../../widgets/_numberInput.dart';
import '../../widgets/customAlertDialoge.dart';
import '../../widgets/widget_dropdownmenu_cities.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  _Profile_Screen createState() => _Profile_Screen();
}

class _Profile_Screen extends State<Profile_Screen> {
  TextEditingController textEditingController_email = TextEditingController();
  bool hidePassword = true;
  TextEditingController textEditingController_password = TextEditingController();
  String? name;
  String? phone;
  String? image;

  String? city;
  String? government;
  var city_id;
  var governId;
  File? imagePick;

  TextEditingController textEditingController_name = TextEditingController();
  TextEditingController textEditingController_mobile = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String token = 'null';

  // late ProgressDialog pr;
  String selectedImagePath = '';

  @override
  void initState() {
    // pr = ProgressDialog(context, showLogs: true);
    context.read<ProfileBloc>().add(ProfileGetData());
    context.read<GovernmentsBloc>().add(const Submission_GovernmentsEvent());
    super.initState();
  }

  Widget bloc_Image() {
    return BlocListener<ChangeImageBloc, ChangeImageState>(
      listener: (context, state) {
        if (state is ChangeImage_Loaded_State) {
          print("----->changeImage_Loaded_State");
          // context.read<AuthHandelBloc>().add(ChangeAuthHandel_Event("is_auth"));
          // // pr.hide();
          _showSnackBar(context, '${(state).model.message}');
        } else if (state is ChangeImage_ErrorState) {
          // pr.hide();
          _showSnackBar(context, '${(state).message}');
        }
      },
      child: Container(),
    );
  }

  Widget bloc_Profile() {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is Profile_Loaded_State) {
          print("----->Profile_Loaded_State");
          // pr.hide();
          myNavigate(screen: Bottom_Bar_Screen(), context: context);
          _showSnackBar(context, '${(state).model.message}');
        } else if (state is Profile_ErrorState) {
          // pr.hide();

          _showSnackBar(context, '${(state).message}');
        }
        // do stuff here based on BlocA's state
      },
      child: Container(),
    );
  }

  Widget AuthHandel(BuildContext context) {
    return BlocBuilder<AuthHandelBloc, AuthHandelState>(
      builder: (context, state) {
        if (state is AuthHande_IsToken) {
          var token = (state).token;
          var is_auth = "is_auth";
          return FutureBuilder<ProfileResponse>(
            future: getData(),
            builder: (context, snapshot) {
              print("snapshot.hasData ${snapshot.hasData}");
              kEcho("snapshot.hasData ${snapshot.hasData}");
              if (snapshot.hasError) {
                return Column(
                  children: [
                    const Text("error"),
                    Text("${snapshot.error}"),
                    TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text("إعادة المحاولة"),
                    )
                  ],
                );
              }
              if (snapshot.hasData) {
                return Form(
                  key: globalFormKey,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w),
                        child: Text(
                          "${LocaleKeys.profile_page.tr()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: HexColor(MyColors.green),
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        decoration: BoxDecoration(
                            color: HexColor(MyColors.white),
                            //new Color.fromRGBO(255, 0, 0, 0.0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.w),
                              topRight: Radius.circular(10.w),
                              bottomLeft: Radius.circular(10.w),
                              bottomRight: Radius.circular(10.w),
                            )),
                        child: Container(
                          margin: EdgeInsets.only(top: 10.h, left: 25.w, right: 25.w, bottom: 10.h),
                          child: Row(
                            children: <Widget>[
                              Stack(
                                children: [
                                  SizedBox(
                                    width: 80.w,
                                    height: 80.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(120),
                                      child: Center(
                                          child: selectedImagePath.isEmpty
                                              ? Image.network(image!, height: MediaQuery.of(context).size.width * .22, width: MediaQuery.of(context).size.width * .22, fit: BoxFit.fill, errorBuilder: (BuildContext, Object, StackTrace) {
                                                  return Container(
                                                    width: 80.w,
                                                    height: 80.h,
                                                    margin: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(250), boxShadow: const [
                                                      BoxShadow(
                                                        color: Color.fromARGB(255, 199, 197, 197),
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 1,
                                                        blurRadius: 0.2,
                                                      )
                                                    ]),
                                                    child: Icon(
                                                      Icons.person,
                                                      size: 40.w,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                })
                                              : Image.file(
                                                  File(selectedImagePath),
                                                  fit: BoxFit.fill,
                                                  height: MediaQuery.of(context).size.width * .22,
                                                  width: MediaQuery.of(context).size.width * .22,
                                                )),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () async {
                                        FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);
                                        if (result != null) {
                                          imagePick = File(
                                            result.files.single.path!,
                                          );
                                          selectedImagePath = imagePick!.path;
                                          // setState(() {});
                                          // pr.show();
                                          context.read<ChangeImageBloc>().add(ChangeImageStart_Event());
                                          context.read<ChangeImageBloc>().add(Submission_ChangeImageEvent(image: selectedImagePath));
                                          // }

                                        }
                                        // });
                                      },
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                                        child: const Center(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              bloc_Image(),
                              Container(
                                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 5.h),
                                      child: Text(
                                        name!,
                                        style: TextStyle(fontSize: 18.sp, color: HexColor(MyColors.green), fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5.h),
                                      child: Text(
                                        phone!,
                                        style: TextStyle(fontSize: 16.sp, color: HexColor(MyColors.black), fontWeight: FontWeight.w200),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5.h),
                                      child: Text(
                                        government! + " " + city!,
                                        style: TextStyle(fontSize: 15.sp, color: HexColor(MyColors.black), fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        child: NameInput(
                          icon: Icon(
                            Icons.person,
                            color: HexColor(MyColors.green),
                          ),
                          textEditingController: textEditingController_name,
                          validation_Message: '${LocaleKeys.Please_write_the_name.tr()}',
                          onSaved: (val) {},
                          maxLines: 1,
                          onChanged: (val) {},
                          hintText: "${LocaleKeys.fname.tr()}",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        child: NumberInput(
                          icon: Icon(
                            Icons.phone_android,
                            color: HexColor(MyColors.green),
                          ),
                          textEditingController: textEditingController_mobile,
                          onSaved: (val) {},
                          maxLines: 1,
                          onChanged: (val) {},
                          hintText: "${LocaleKeys.mobile.tr()}",
                          validator: (value) => value!.isEmpty
                              ? '${LocaleKeys.phone_valid.tr()}'
                              : textEditingController_mobile.text.length > 10
                                  ? null
                                  : '${LocaleKeys.phone_valid.tr()}',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 0.w, right: 0.w, top: 8.h),
                        child: EmailInput(
                          textEditingController: textEditingController_email,
                          onSaved: (val) {},
                          onChanged: (val) {},
                          hintText: "${LocaleKeys.mail.tr()}",
                          prefixIcon: Icon(
                            Icons.email,
                            color: HexColor(MyColors.green),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        child: PasswordField(
                          textEditingController: textEditingController_password,
                          onPressed: () {
                            // setState(() {});
                            hidePassword = !hidePassword;
                          },
                          hidePassword: hidePassword,
                          onSaved: (val) {},
                          label: '${LocaleKeys.password.tr()}',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        width: double.infinity,
                        child: Widget_governments(
                          icon: Icon(
                            Icons.location_on,
                            color: HexColor(MyColors.green),
                          ),
                          onChanged: (val) {
                            context.read<CitiesBloc>().add(Start_CitiesEvent());
                            context.read<CitiesBloc>().add(Submission_CitiesEvent(val.id));

                            setState(() {
                              governId = val.id;
                            });
                            // city_id = null;
                            // city = null;
                          },
                          onSaved: (val) {},
                          currentValue: government!,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        width: double.infinity,
                        child: Widget_DropdownMenu_Cities(
                          icon: Icon(
                            Icons.apartment_outlined,
                            color: HexColor(MyColors.green),
                          ),
                          onChanged: (val) {
                            // setState(() {});
                            city_id = val.id;
                            city = val.name;
                          },
                          onSaved: (val) {},
                          currentValue: city!,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40.w, right: 40.w, top: 30.h),
                        height: 50.h,
                        child: Button_Widget(
                          fontSize: 18.sp,
                          color_text: HexColor(MyColors.white),
                          color: HexColor(MyColors.green),
                          onTap: () {
                            if (city_id == null && city != null) {
                              CitiesState state = context.read<CitiesBloc>().state;
                              if (state is Cities_Loaded_State) {
                                Model_Cities modelCountryList = (state).model;
                                List<Data_Items_Model_Cities> selectedValueList = modelCountryList.items.data.where((element) => element.name == city).toList();
                                if (selectedValueList.isNotEmpty) {
                                  city_id = selectedValueList.first.id;
                                }
                              }
                            }

                            if (governId == null && government != null) {
                              GovernmentsState state = context.read<GovernmentsBloc>().state;
                              if (state is Governments_Loaded_State) {
                                Model_Governments modelCountryList = (state).model;
                                List<Data_Items_Governments> selectedValueList = modelCountryList.items.data.where((element) => element.name == government).toList();
                                if (selectedValueList.isNotEmpty) {
                                  governId = selectedValueList.first.id;
                                }
                              }
                            }

                            if (city_id == null || governId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('من فضلك اختر المحافظة والمدينة'),
                              ));
                              return;
                            }

                            if (validateAndSave()) {
                              // pr.show();
                              context.read<ProfileBloc>().add(Profile_StartEvent());
                              context.read<ProfileBloc>().add(Submission_ProfileEvent(
                                    name: textEditingController_name.text,
                                    email: textEditingController_email.text,
                                    city_id: '$city_id',
                                    phone: textEditingController_mobile.text,
                                    password: textEditingController_password.text,
                                    govern_id: '$governId',
                                  ));
                            }
                          },
                          tittle: '${LocaleKeys.Edit_data.tr()}',
                        ),
                      ),
                      bloc_Profile(),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: GestureDetector(
                          onTap: () async {
                            //show dialog
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Delete Account'),
                                  content: Text('Are you sure you want to delete your account?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Repository repository = Repository(Services(), Data_Local());
                                        final model = await repository.deleteProfile();
                                        if (model is bool && model == true) {
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SplashScreen()), (Route<dynamic> route) => false);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text('حدث خطأ ما'),
                                          ));
                                        }
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            'Delete Account',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        } else {
          print("----->AuthHande_Is_notaction else ");

          var is_auth = "is_Guest";
          return CustomAlertDialog(
            fromLogin: false,
            title: "يرجي التسجيل اولا",
            image: 'assets/lo.png',
            onBtnTap: () {
              myNavigate(screen: Login_Screen(), context: context);
            },
            btnTitle: 'تسجيل الدخول',
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthHandel(context);
  }

  Future<ProfileResponse> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Repository repository = Repository(Services(), Data_Local());

    try {
      ProfileResponse res = await repository.getProfile();
      name = res.items.name;
      phone = res.items.phone;
      image = res.items.image;
      city = res.items.city;
      government = res.items.govern;
      token = preferences.getString(ACCESS_TOKEN)!;
      textEditingController_email.text = res.items.email;
      textEditingController_name.text = res.items.name;
      textEditingController_mobile.text = res.items.phone;
      return res;
    } catch (e) {
      return Future.error('$e');
    }
  }
}

void _showSnackBar(BuildContext context, String message) {
  // LoginResponse_Error loginResponse_Error=new LoginResponse_Error.fromJson(json.decode(message));
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
