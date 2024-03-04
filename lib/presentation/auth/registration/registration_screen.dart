import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc/cities/cities_bloc.dart';
import '../../../bloc/governments/governments_bloc.dart';
import '../../../bloc/register/register_bloc.dart';
import '../../../constants/my_colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../router/router_path.dart';
import '../../widgets/Widget_DropdownMenu_governments.dart';
import '../../widgets/_EmailInput.dart';
import '../../widgets/_nameInput.dart';
import '../../widgets/_numberInput.dart';
import '../../widgets/_passwordField.dart';
import '../../widgets/app_bar_auth.dart';
import '../../widgets/button.dart';
import '../../widgets/widget_dropdownmenu_cities.dart';

class Registration_Screen extends StatefulWidget {
  @override
  _Registration_Screen createState() => _Registration_Screen();
}

class _Registration_Screen extends State<Registration_Screen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late var email, password;
  TextEditingController textEditingController_email = TextEditingController();
  TextEditingController textEditingController_password =
      TextEditingController();
  TextEditingController textEditingController_img = TextEditingController();
  TextEditingController textEditingController_name = TextEditingController();
  TextEditingController textEditingController_mobile = TextEditingController();
  XFile? image;
  // late ProgressDialog pr;
  var city_id;
  var governmentId;

  @override
  void initState() {
    // pr = ProgressDialog(context, showLogs: true);
    context.read<GovernmentsBloc>().add(const Submission_GovernmentsEvent());
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

  Widget bloc_reg() {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is Register_Loaded_State && !state.model.status.contains("false")) {
          print("----->Register_Loaded_State");

          // pr.hide();
          Navigator.pushNamed(context, Login);

          _showSnackBar(context, (state).model.message);
        } else if (state is Register_Loaded_State) {
          // pr.hide();
          _showSnackBar(context, (state).model.message);
        }else if (state is Register_ErrorState) {
          // pr.hide();
          _showSnackBar(context, (state).message);
        }
        // do stuff here based on BlocA's state
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: HexColor(MyColors.gray_light2),
        body: SafeArea(
            child: Form(
          key: globalFormKey,
          child: ListView(children: <Widget>[
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: HexColor(
                    MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  App_Bar_Auth(),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: NameInput(
                icon: Icon(
                  Icons.person,
                  color: HexColor(MyColors.green),
                ),
                textEditingController: textEditingController_name,
                validation_Message: LocaleKeys.Please_write_the_name.tr(),
                onSaved: (val) {},
                maxLines: 1,
                onChanged: (val) {},
                hintText: LocaleKeys.fname.tr(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: EmailInput(
                textEditingController: textEditingController_email,
                onSaved: (val) {},
                onChanged: (val) {},
                hintText: LocaleKeys.mail.tr(),
                prefixIcon: Icon(
                  Icons.mail,
                  color: HexColor(MyColors.green),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: NumberInput(
                icon: Icon(
                  Icons.phone_android,
                  color: HexColor(MyColors.green),
                ),
                textEditingController: textEditingController_mobile,
                onSaved: (val) {},
                maxLines: 1,
                onChanged: (val) {},
                hintText: LocaleKeys.mobile.tr(),
                validator: (value) => value!.isEmpty
                    ? LocaleKeys.phone_valid.tr()
                    : textEditingController_mobile.text.length > 10
                        ? null
                        : LocaleKeys.phone_valid.tr(),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: PasswordField(
                textEditingController: textEditingController_password,
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                hidePassword: hidePassword,
                onSaved: (val) => password = val,
                label: LocaleKeys.password.tr(),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
            //   decoration: new BoxDecoration(
            //     color: HexColor(MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
            //     borderRadius: new BorderRadius.only(
            //       bottomLeft: Radius.circular(2.r),
            //       bottomRight: Radius.circular(2.r),
            //       topLeft: Radius.circular(2.r),
            //       topRight: Radius.circular(2.r),
            //     ),
            //   ),
            //   child: NameInput(
            //     icon: Icon(Icons.location_on,color: HexColor(MyColors.green),),
            //     textEditingController: textEditingController_email,
            //     validation_Message: '',
            //     onSaved: (val){
            //
            //     },
            //     maxLines: 1,
            //     onChanged: (val){
            //
            //     },
            //     hintText: "${LocaleKeys.Governorate.tr()}",
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
            //
            //   child: ImgInput(
            //     icon: null,
            //     textEditingController: textEditingController_img,
            //     validation_Message: '${LocaleKeys.img_valid.tr()}',
            //     onSaved: (val) {},
            //     maxLines: 1,
            //     onChanged: (val) {},
            //     hintText: "${LocaleKeys.Choose_picture.tr()}",
            //     onTap: () async {
            //       var image_uri = await ImagePicker.platform
            //           .getImage(source: ImageSource.gallery);
            //
            //       setState(() {
            //         textEditingController_img.text = image_uri!.path;
            //       });
            //     },
            //     prefixIcon: Icon(
            //     Icons.image,
            //     color: HexColor(MyColors.green),
            //   ),),
            // ),
            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              width: double.infinity,
              child: Widget_governments(
                icon: Icon(
                  Icons.location_on,
                  color: HexColor(MyColors.green),
                ),
                onChanged: (val) {
                  context.read<CitiesBloc>().add(Start_CitiesEvent());
                  context
                      .read<CitiesBloc>()
                      .add(Submission_CitiesEvent(val.id));
                  governmentId = val.id;
                },
                onSaved: (val) {},
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 5.h),
              width: double.infinity,
              child: Widget_DropdownMenu_Cities(
                icon: Icon(
                  Icons.apartment_outlined,
                  color: HexColor(MyColors.green),
                ),
                onChanged: (val) {
                  setState(() {
                    city_id = val.id;
                  });
                },
                onSaved: (val) {},
              ),
            ),

            // Container(
            //   margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
            //   decoration: new BoxDecoration(
            //     color: HexColor(MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
            //     borderRadius: new BorderRadius.only(
            //       bottomLeft: Radius.circular(2.r),
            //       bottomRight: Radius.circular(2.r),
            //       topLeft: Radius.circular(2.r),
            //       topRight: Radius.circular(2.r),
            //     ),
            //   ),
            //   child: NameInput(
            //     icon: Icon(Icons.apartment_outlined,color: HexColor(MyColors.green),),
            //     textEditingController: textEditingController_email,
            //     validation_Message: '',
            //     onSaved: (val){
            //
            //     },
            //     maxLines: 1,
            //     onChanged: (val){
            //
            //     },
            //     hintText: "${LocaleKeys.City.tr()}",
            //   ),
            // ),

            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
              height: 50.h,
              child: Button_Widget(
                fontSize: 18.sp,
                color_text: HexColor(MyColors.white),
                color: HexColor(MyColors.green),
                onTap: () {
                  if (validateAndSave()) {
                    // pr.show();
                    print("----->object resg" +
                        textEditingController_name.text +
                        "  " +
                        textEditingController_email.text +
                        "  " +
                        city_id.toString() +
                        " " +
                        textEditingController_mobile.text +
                        " " +
                        textEditingController_password.text +
                        " " +
                        governmentId.toString());
                    context.read<RegisterBloc>().add(Register_StartEvent());
                    context.read<RegisterBloc>().add(Submission_RegisterEvent(
                          name: textEditingController_name.text,
                          email: textEditingController_email.text,
                          city_id: '$city_id',
                          phone: textEditingController_mobile.text,
                          password: textEditingController_password.text,
                          governmentId: '$governmentId',
                        ));
                  }
                },
                tittle: LocaleKeys.Create_account.tr(),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, Login);
              },
              title: Container(
                margin: EdgeInsets.only(
                    left: 30.w, right: 30.w, top: 20.h, bottom: 20.h),
                width: double.infinity,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_outlined,
                      color: HexColor(MyColors.gray),
                      size: 20.w,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: Text(
                        LocaleKeys.you_have_an_account.tr(),
                        style: TextStyle(
                            fontSize: 16.sp, color: HexColor(MyColors.gray)),
                      ),
                    )
                  ],
                ),
              ),
            ),

            bloc_reg()
          ]),
        )));
  }
}

void _showSnackBar(BuildContext context, String message) {
  // LoginResponse_Error loginResponse_Error=new LoginResponse_Error.fromJson(json.decode(message));
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
