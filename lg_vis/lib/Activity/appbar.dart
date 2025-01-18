import 'package:flutter/material.dart';
import 'package:lg_vis/utils/device/device_utils.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class LgAppBar extends StatelessWidget implements PreferredSizeWidget{
  const LgAppBar({super.key,
  this.title,
  this.actions,
  this.showBackArrow=false});

  final Widget? title;
  final List<Widget>? actions;
  final bool showBackArrow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow ? IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Iconsax.arrow_left_1_outline, color: Theme.of(context).splashColor, size: 25.0,)) : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(LgDeviceUtils.getAppBarHeight());
}
