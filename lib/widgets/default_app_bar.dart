import 'dart:io';

import 'package:air_quality_index/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final bool? automaticallyImplyLeading;
  final List<Widget>? actions;
  final TextStyle? style;
  final Color? backgroundColor;
  final bool centerTitle;
  final double? elevation;
  final double? toolbarHeight;
  final Widget? flexibleSpace;
  const DefaultAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.automaticallyImplyLeading,
    this.actions,
    this.style,
    this.backgroundColor,
    this.centerTitle = true,
    this.elevation,
    this.toolbarHeight,
    this.flexibleSpace,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: subtitle == null
          ? Text(
              title ?? '',
              style: style != null ? style! : null,
              textScaleFactor: 1.0,
            )
          : Column(
              crossAxisAlignment: Platform.isAndroid
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Text(
                  title ?? '',
                  style: style != null ? style! : null,
                  textScaleFactor: 1.0,
                ),
                Text(
                  subtitle ?? '',
                  style: GoogleFonts.dmSans(
                    color: secondaryColor,
                    fontSize: 12,
                  ),
                  textScaleFactor: 1.0,
                ),
              ],
            ),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      actions: actions,
      backgroundColor: backgroundColor,
      centerTitle:
          centerTitle ? (Platform.isAndroid ? false : true) : centerTitle,
      elevation: elevation ?? 0.0,
      toolbarHeight: toolbarHeight,
      flexibleSpace: flexibleSpace,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
