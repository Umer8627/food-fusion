import 'package:flutter/material.dart';
import 'package:food_fusion/constants/color_constant.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeading;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.showLeading,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.showLeading,
      elevation: 0,
      backgroundColor: secondaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text('Hi, ${widget.title}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18)),
    );
  }
}
