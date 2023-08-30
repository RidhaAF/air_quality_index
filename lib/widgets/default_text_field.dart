import 'package:air_quality_index/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final String? labelText;
  final InputBorder? focusedBorder;
  final Color? focusedBorderColor;
  final String? hintText;
  final Widget? prefix;
  final Widget? prefixIcon;
  final String? prefixText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String? suffixText;
  final InputBorder? border;
  final Color? borderColor;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool? readOnly;
  final bool? autofocus;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;
  final bool? expands;
  final int? maxLength;
  final bool? enabled;
  final Color? cursorColor;
  final Iterable<String>? autofillHints;
  final Function? onChanged;
  final Function? onTap;
  final Function? onFieldSubmitted;
  final Function? validator;
  const DefaultTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization,
    this.labelText,
    this.focusedBorder,
    this.focusedBorderColor,
    this.hintText,
    this.prefix,
    this.prefixIcon,
    this.prefixText,
    this.suffix,
    this.suffixIcon,
    this.suffixText,
    this.border,
    this.borderColor,
    this.style,
    this.textAlign,
    this.readOnly,
    this.autofocus,
    this.obscureText,
    this.maxLines,
    this.minLines,
    this.expands,
    this.maxLength,
    this.enabled,
    this.cursorColor,
    this.autofillHints,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: decoration ??
          InputDecoration(
            labelText: labelText ?? 'Search...',
            labelStyle: GoogleFonts.dmSans(
              color: focusNode != null && focusNode!.hasFocus
                  ? primaryColor
                  : mutedColor,
            ),
            hintText: hintText ?? 'Search...',
            hintStyle: GoogleFonts.dmSans(
              color: mutedColor,
            ),
            prefix: prefix,
            prefixIcon: prefixIcon,
            prefixText: prefixText,
            prefixStyle: GoogleFonts.dmSans(
              color: mutedColor,
            ),
            prefixIconColor: primaryColor,
            suffix: suffix,
            suffixIcon: suffixIcon,
            suffixText: suffixText,
            suffixStyle: GoogleFonts.dmSans(
              color: mutedColor,
            ),
            suffixIconColor: primaryColor,
            border: border ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor ?? primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusedBorderColor ?? primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
          ),
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.done,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      style: style ?? subheadline,
      textAlign: textAlign ?? TextAlign.start,
      readOnly: readOnly ?? false,
      autofocus: autofocus ?? false,
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      expands: expands ?? false,
      maxLength: maxLength,
      enabled: enabled ?? true,
      cursorColor: cursorColor ?? primaryColor,
      autofillHints: autofillHints,
      onChanged: (value) => onChanged != null ? onChanged!(value) : null,
      onTap: () => onTap != null ? onTap!() : null,
      onFieldSubmitted: (value) =>
          onFieldSubmitted != null ? onFieldSubmitted!(value) : null,
      validator: (value) => validator != null ? validator!(value) : null,
    );
  }
}
