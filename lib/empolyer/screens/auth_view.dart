import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/models/city.dart';
import 'package:hayaah_karimuh/empolyer/models/governorate.dart';
import 'package:hayaah_karimuh/empolyer/models/requests/login_request.dart';
import 'package:hayaah_karimuh/empolyer/models/requests/register_request.dart';
import 'package:hayaah_karimuh/empolyer/providers/auth_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/main_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/empolyer/widgets/custom_button.dart';
import 'package:hayaah_karimuh/empolyer/widgets/custom_text_field.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _govController;
  late TextEditingController _cityController;
  late TextEditingController _roleController;
  late TextEditingController _attachController;

  late FocusNode _nameFocusNode;
  late FocusNode _phoneFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  late GlobalKey<FormState> _formKey;

  bool _isLogin = true;

  File? _selectedFile;

  late AuthProvider _authProvider;

  Governorate? _selectedGovernorate;

  City? _selectedCity;

  int? _selectedRole;

  @override
  void initState() {
    super.initState();

    _authProvider = Provider.of<AuthProvider>(context, listen: false);

    _formKey = GlobalKey<FormState>();

    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _govController = TextEditingController();
    _cityController = TextEditingController();
    _roleController = TextEditingController();
    _attachController = TextEditingController();

    _nameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  void _showGovernoratesDialog() async {
    _cityController.text = '';
    _selectedCity = null;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder<List<Governorate>>(
              future: _authProvider.getGovernorates(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        primary: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                _selectedGovernorate = snapshot.data![index];
                                _govController.text = _selectedGovernorate!.name!;
                                Navigator.of(context).pop();
                              });
                            },
                            dense: true,
                            title: Text(
                              snapshot.data![index].name!,
                              style: GoogleFonts.cairo(
                                color: AppColors.primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              }),
        );
      },
    );
  }

  void _showCitiesDialog(int id) async {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            itemCount: _selectedGovernorate!.cities!.length,
            shrinkWrap: true,
            primary: true,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  setState(() {
                    _selectedCity = _selectedGovernorate!.cities![index];
                    _cityController.text = _selectedCity!.name!;
                    Navigator.of(context).pop();
                  });
                },
                dense: true,
                title: Text(
                  _selectedGovernorate!.cities![index].name!,
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showRolesDialog() async {
    List<Map<String, dynamic>> roles = [
      {'role': 'ادمن', 'id': 1},
      {'role': 'مدير عمليات', 'id': 2},
      {'role': 'مشرف عمليات', 'id': 3},
      {'role': 'متبرع', 'id': 4}
    ];
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            itemCount: roles.length,
            shrinkWrap: true,
            primary: true,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  setState(() {
                    _selectedRole = roles[index]['id'] as int;
                    _roleController.text = roles[index]['role'];
                    Navigator.of(context).pop();
                  });
                },
                dense: true,
                title: Text(
                  roles[index]['role'],
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showAttachmentBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Wrap(
              textDirection: TextDirection.rtl,
              children: [
                ListTile(
                    leading: const Icon(
                      Icons.image,
                      color: AppColors.appOrange,
                    ),
                    title: Text(
                      'صورة',
                      style: GoogleFonts.cairo(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    onTap: () => _showFilePicker(FileType.image)),
                ListTile(
                  leading: const Icon(
                    Icons.insert_drive_file,
                    color: AppColors.appOrange,
                  ),
                  title: Text('ملف',
                      style: GoogleFonts.cairo(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                  onTap: () => _showFilePicker(FileType.any),
                ),
              ],
            ),
          );
        });
  }

  void _showFilePicker(FileType fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: fileType);
    if (result != null) {
      log('File Path: ${result.files.single.path!}');
      Navigator.pop(context);

      setState(() {
        _selectedFile = File(result.files.single.path!);
        _attachController.text = path.basename(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          primary: true,
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 220,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Color(0x29000000), offset: Offset(0, 2), blurRadius: 6, spreadRadius: 0),
                  ],
                ),
                child: Center(
                  child: SizedBox(
                    width: 144,
                    height: 166,
                    child: Image.asset(
                      PngImages.logo,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_isLogin)
                        CustomTextField(
                          hintText: 'الاسم',
                          prefixIcon: SvgPicture.asset(
                            SvgImages.person,
                            fit: BoxFit.scaleDown,
                          ),
                          textInputType: TextInputType.name,
                          fillColor: Colors.white,
                          controller: _nameController,
                          capitalization: TextCapitalization.words,
                          focusNode: _nameFocusNode,
                          textInputAction: TextInputAction.next,
                          nextNode: _phoneFocusNode,
                          // isValidator: true,
                        ),
                      if (!_isLogin)
                        const SizedBox(
                          height: 15,
                        ),
                      // if (!_isLogin)
                      CustomTextField(
                        hintText: 'الموبايل',
                        prefixIcon: SvgPicture.asset(
                          SvgImages.mobile,
                          fit: BoxFit.scaleDown,
                        ),
                        fillColor: Colors.white,
                        textInputType: TextInputType.phone,
                        controller: _phoneController,
                        isPhoneNumber: true,
                        focusNode: _phoneFocusNode,
                        textInputAction: TextInputAction.next,
                        nextNode: _emailFocusNode,
                        // isValidator: true,
                      ),
                      if (!_isLogin)
                        const SizedBox(
                          height: 15,
                        ),
                      if (!_isLogin)
                        CustomTextField(
                          hintText: 'البريد الالكتروني',
                          prefixIcon: SvgPicture.asset(
                            SvgImages.email,
                            fit: BoxFit.scaleDown,
                          ),
                          fillColor: Colors.white,
                          textInputType: TextInputType.emailAddress,
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          nextNode: _passwordFocusNode,
                          // isValidator: true,
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hintText: 'كلمة المرور',
                        prefixIcon: SvgPicture.asset(
                          SvgImages.lock,
                          fit: BoxFit.scaleDown,
                        ),
                        isPassword: true,
                        fillColor: Colors.white,
                        textInputType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        // isValidator: true,
                      ),
                      if (!_isLogin)
                        const SizedBox(
                          height: 15,
                        ),
                      if (!_isLogin)
                        CustomTextField(
                          readOnly: true,
                          onTap: () {
                            _showGovernoratesDialog();
                          },
                          controller: _govController,
                          hintText: 'المحافظة',
                          prefixIcon: SvgPicture.asset(
                            SvgImages.location,
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: SvgPicture.asset(
                            SvgImages.dropDown,
                            fit: BoxFit.scaleDown,
                          ),
                          fillColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          // isValidator: true,
                        ),
                      if (!_isLogin)
                        const SizedBox(
                          height: 15,
                        ),
                      if (!_isLogin)
                        CustomTextField(
                          onTap: () {
                            _showCitiesDialog(_selectedGovernorate!.id!);
                          },
                          readOnly: true,
                          enabled: true,
                          controller: _cityController,
                          hintText: 'المدينة',
                          prefixIcon: SvgPicture.asset(
                            SvgImages.city,
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: SvgPicture.asset(
                            SvgImages.dropDown,
                            fit: BoxFit.scaleDown,
                          ),
                          fillColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          // isValidator: true,
                        ),
                      if (!_isLogin)
                        const SizedBox(
                          height: 15,
                        ),
                      if (!_isLogin)
                        CustomTextField(
                          controller: _attachController,
                          readOnly: true,
                          onTap: () {
                            _showAttachmentBottomSheet(context);
                          },
                          hintText: 'ارفاق ملفات',
                          prefixIcon: SvgPicture.asset(
                            SvgImages.document,
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: SvgPicture.asset(
                            SvgImages.attachDoc,
                            fit: BoxFit.scaleDown,
                          ),
                          fillColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          // isValidator: true,
                        ),
                      if (!_isLogin)
                        const SizedBox(
                          height: 15,
                        ),
                      if (!_isLogin)
                        CustomTextField(
                          readOnly: true,
                          onTap: () {
                            _showRolesDialog();
                          },
                          controller: _roleController,
                          hintText: 'المسمى الوظيفى',
                          prefixIcon: SvgPicture.asset(
                            SvgImages.rule,
                            fit: BoxFit.scaleDown,
                          ),
                          fillColor: Colors.white,
                          suffixIcon: SvgPicture.asset(
                            SvgImages.dropDown,
                            fit: BoxFit.scaleDown,
                          ),
                          textInputAction: TextInputAction.done,
                          // isValidator: true,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              CustomButton(
                onPressed: () async {
                  log('onTap');
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_isLogin) {
                    await Provider.of<AuthProvider>(context, listen: false).login(LoginRequest(phone: _phoneController.value.text, password: _passwordController.value.text),
                        (bool isRoute, String errorMessage) async {
                      if (isRoute) {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const MainScreen()), (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "كلمة المرور أو رقم الهاتف غير صحيح",
                              // errorMessage,
                              style: GoogleFonts.cairo(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    });
                  } else {
                    if (_nameController.value.text.isNotEmpty &&
                        _selectedCity!.id != null &&
                        _passwordController.value.text.isNotEmpty &&
                        _emailController.value.text.isNotEmpty &&
                        _phoneController.value.text.isNotEmpty &&
                        _selectedRole != null &&
                        _selectedFile != null) {
                      RegisterRequest registerRequest = RegisterRequest(
                          name: _nameController.value.text,
                          isAccepted: 0,
                          cityId: _selectedCity!.id!,
                          confirmPassword: _passwordController.value.text,
                          password: _passwordController.value.text,
                          email: _emailController.value.text,
                          phone: _phoneController.value.text,
                          roleId: _selectedRole!);

                      Map<String, dynamic> registerData = registerRequest.toJson();
                      MultipartFile file;
                      if (_selectedFile != null) {
                        log('Image Path: ${_selectedFile!.path}');
                        file = await MultipartFile.fromFile(_selectedFile!.path, filename: path.basename(_selectedFile!.path));
                        registerData.addAll({'assignment_documentation': file});
                      }

                      await Provider.of<AuthProvider>(context, listen: false).register(registerData, (bool isRoute, String errorMessage) async {
                        if (isRoute) {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const MainScreen()), (route) => false);
                        } else {
                          setState(() {
                            _isLogin = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                errorMessage,
                                style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'برجاء ملئ جميع الحقول',
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                margin: const EdgeInsets.symmetric(horizontal: 30),
                buttonText: _isLogin ? 'تسجيل دخول' : 'انشاء حساب',
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isLogin ? 'انشاء حساب' : "لديك حساب",
                      style: GoogleFonts.cairo(
                        color: AppColors.darkGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    SvgPicture.asset(SvgImages.materialBackArrow),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
