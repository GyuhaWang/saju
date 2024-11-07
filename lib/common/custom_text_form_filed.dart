import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saju/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget? counter;
  final EdgeInsetsGeometry contentPadding;
  final GestureTapCallback? onTap;
  final String hintText;
  final String initialValue;
  final bool autofocus;
  final bool obscureText;
  final bool expands;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final String? labelText;
  final TextInputAction? textInputAction;

  final ValueChanged<String>? onChanged;
  const CustomTextFormField({
    this.counter,
    this.contentPadding = const EdgeInsets.all(16.0),
    this.keyboardType,
    this.inputFormatters,
    this.onTap,
    this.hintText = '',
    this.initialValue = '',
    this.autofocus = false,
    this.obscureText = false,
    this.expands = false,
    this.maxLength,
    this.maxLines,
    this.labelText,
    this.textInputAction,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: OdoSajuColors.iceBlue,
        width: 1.0,
      ),
    );
    return TextFormField(
      onTap: onTap,
      initialValue: initialValue,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      cursorColor: OdoSajuColors.black01,
      autofocus: autofocus,
      obscureText: obscureText,
      onChanged: onChanged,
      textInputAction: textInputAction,
      expands: expands,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        counter: counter,
        hintText: hintText,
        labelText: labelText,
        contentPadding: contentPadding,
        border: baseBorder,
        filled: true,
        fillColor: OdoSajuColors.iceBlue,
        enabledBorder: baseBorder.copyWith(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
          borderSide: BorderSide(
            color: OdoSajuColors.iceBlue,
            width: 1.0,
          ),
        ),
        focusedBorder: baseBorder.copyWith(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
          borderSide: BorderSide(
            color: OdoSajuColors.iceBlue,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
