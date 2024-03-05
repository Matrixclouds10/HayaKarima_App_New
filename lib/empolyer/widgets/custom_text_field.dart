import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(this);
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool enabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextCapitalization? capitalization;
  final double? height;
  final void Function()? onTap;

  const CustomTextField(
      {this.controller,
      this.hintText,
      this.onTap,
      this.enabled = true,
      this.textInputType,
      this.maxLine,
      this.focusNode,
      this.nextNode,
      this.readOnly = false,
      this.prefixIcon,
      this.isPassword = false,
      this.suffixIcon,
      this.textInputAction,
      this.isPhoneNumber = false,
      this.isValidator = false,
      this.validatorMessage,
      this.capitalization = TextCapitalization.none,
      this.fillColor,
      this.height = 50,
      Key? key})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      // alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        maxLines: widget.maxLine ?? 1,
        keyboardType: widget.textInputType ?? TextInputType.text,
        maxLength: widget.isPhoneNumber ? 15 : null,
        focusNode: widget.focusNode,
        initialValue: null,
        obscureText: widget.isPassword ? _obscureText : false,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(widget.nextNode);
        },
        autovalidateMode: AutovalidateMode.always,
        inputFormatters: [widget.isPhoneNumber ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter],
        validator: (input) {
          if (input!.isEmpty) {
            if (widget.isValidator) {
              return widget.validatorMessage ?? "";
            }
          }
          return null;
        },
        style: GoogleFonts.cairo(
          color: AppColors.textColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText ?? '',
          filled: widget.fillColor != null,
          fillColor: widget.fillColor,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).primaryColor,
                    size: 21,
                  ),
                  onPressed: _toggle)
              : widget.suffixIcon,
          contentPadding: const EdgeInsets.all(12),
          isDense: true,
          counterText: '',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          hintStyle: GoogleFonts.cairo(
            color: AppColors.hintColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          floatingLabelStyle: GoogleFonts.cairo(
            color: AppColors.hintColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          counterStyle: GoogleFonts.cairo(
            color: AppColors.hintColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          helperStyle: GoogleFonts.cairo(
            color: AppColors.hintColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          labelStyle: GoogleFonts.cairo(
            color: AppColors.hintColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          errorStyle: const TextStyle(height: 1.5),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
