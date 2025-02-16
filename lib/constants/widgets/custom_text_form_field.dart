import 'package:flutter/material.dart';

import '../theme/app_colors.dart';


class CustomTextFormField extends StatefulWidget{
  String? iconPath;
  bool hasIcon;
  String hintText;
  String? Function(String?)? validator;
  bool isPassword;
  int? maxLines;
  int? minLines;
  Color? hintTextColor;
  Color? iconColor;
  Color? borderColor;
  TextEditingController? controller;




  CustomTextFormField({
    super.key,
    this.iconPath,
    this.hasIcon = true,
    required this.hintText,
    this.validator,
    this.isPassword = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.hintTextColor,
    this.iconColor,
    this.borderColor,
    this.controller,


  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      validator: widget.validator,
      obscureText: widget.isPassword ? obscureText : false,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        prefixIcon: widget.hasIcon && widget.iconPath != null
            ? Padding(
          padding: const EdgeInsets.all(9.0),
          child: ImageIcon(
            AssetImage(widget.iconPath!),
            color: widget.iconColor ?? AppColors.primaryColorDark,
          ),
        ) : null,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          )
              : null,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: widget.hintTextColor ?? AppColors.primaryColorDark,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color:  widget.borderColor ?? AppColors.primaryColorDark,
              )
          ),
        focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color:  widget.borderColor ?? AppColors.primaryColorDark,
            )
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.red,
        )
    ),
      ),
    );
  }
}