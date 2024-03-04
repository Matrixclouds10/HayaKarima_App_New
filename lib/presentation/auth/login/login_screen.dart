import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../bloc/AuthHandel/auth_handel_bloc.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../constants/my_colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../router/router_path.dart';
import '../../widgets/_numberInput.dart';
import '../../widgets/_passwordField.dart';
import '../../widgets/app_bar_auth.dart';
import '../../widgets/button.dart';
import '../../widgets/customAlertDialoge.dart';

class Login_Screen extends StatefulWidget {
  @override
  _Login_Screen createState() => _Login_Screen();
}

class _Login_Screen extends State<Login_Screen> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late var email, password;
  TextEditingController textEditingController_email =
      TextEditingController();
  TextEditingController textEditingController_password =
      TextEditingController();
  // late ProgressDialog pr;

  @override
  void initState() {
    // pr = ProgressDialog(context, showLogs: true);
    super.initState();
  }

  Widget bloc_login() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is Login_Loaded_State) {
          print("----->Login_Loaded_State");
          context.read<AuthHandelBloc>().add(ChangeAuthHandel_Event("is_auth"));
          // pr.hide();
          Navigator.pushNamed(context, home_screen);

          ///mobark
          showDialog(
            barrierColor: Colors.black26,
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                fromLogin: true,
                title: (state).model.message,
                image: 'assets/lo.png',
                onBtnTap: () {},
                btnTitle: 'العودة للرئيسية',
              );
            },
          );
          // _showSnackBar(context, '${(state).model.message}');
        } else if (state is Login_ErrorState) {
          // pr.hide();
          _showSnackBar(context, (state).message);
        }
      },
      child: Container(),
    );
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
            margin: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 100.h, bottom: 10.h),
            child: NumberInput(
              icon: Icon(
                Icons.phone_android,
                color: HexColor(MyColors.green),
              ),
              textEditingController: textEditingController_email,
              validator: (value) => value!.isEmpty
                  ? LocaleKeys.phone_valid.tr()
                  : textEditingController_email.text.length > 10
                      ? null
                      : LocaleKeys.phone_valid.tr(),
              maxLines: 1,
              onChanged: (val) {},
              hintText: LocaleKeys.mobile.tr(),
              onSaved: (val) {},
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
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
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
            height: 50.h,
            child: Button_Widget(
              fontSize: 18.sp,
              color_text: HexColor(MyColors.white),
              color: HexColor(MyColors.green),
              onTap: () {
                if (validateAndSave()) {
                  // pr.show();
                  context.read<LoginBloc>().add(Login_StartEvent());
                  context.read<LoginBloc>().add(Submission_LoginEvent(
                      textEditingController_email.text,
                      textEditingController_password.text));
                } else {}
              },
              tittle: LocaleKeys.login.tr(),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, Registration);
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
                      LocaleKeys.Create_account.tr(),
                      style: TextStyle(
                          fontSize: 16.sp, color: HexColor(MyColors.gray)),
                    ),
                  )
                ],
              ),
            ),
          ),
          bloc_login()
        ]),
      )),
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  // LoginResponse_Error loginResponse_Error=new LoginResponse_Error.fromJson(json.decode(message));
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
