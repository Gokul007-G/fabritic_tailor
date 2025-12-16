import 'package:fabritic/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class FormTextfiled extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final bool? obscureText;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final bool? readOnly;
  final VoidCallback? onPressed;
  final String? Function(String?)? validator;

  FormTextfiled({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.readOnly,
    this.obscureText,
    this.onPressed,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppColors(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        cursorColor: colors.primary,
        keyboardType: inputType,
        readOnly: readOnly ?? false,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(prefixIcon, color: colors.primary),
          suffixIcon: suffixIcon,

          // suffixIcon: IconButton( onPressed: (){}, suffixIcon, color: colors.primary),
          filled: true,
          fillColor: theme.inputDecorationTheme.fillColor ?? colors.secondary,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: colors.primary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: colors.secondary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: colors.error, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: colors.error, width: 2),
          ),
        ),
      ),
    );
  }
}
