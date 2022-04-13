import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Widget? flexibleSpace;
  final double appBarHeight;

  @override
  final Size preferredSize;

  CustomAppBar({
    Key? key,
    this.leading,
    this.title,
    this.actions,
    this.centerTitle,
    this.flexibleSpace,
    this.appBarHeight = 58.0,
  })  : preferredSize = Size.fromHeight(appBarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      centerTitle: centerTitle,
      actions: actions,
      flexibleSpace: flexibleSpace,
    );
  }
}



