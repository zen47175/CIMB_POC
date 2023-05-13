import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(74);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFEE1C24),
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
      automaticallyImplyLeading: false,
      elevation: 4, // This corresponds to the box-shadow blur radius
      title: const SizedBox.shrink(), // Empty widget
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20),
            child: Image.asset(
              'assets/images/Logo.png',
              width: 112,
              height: 30,
            ),
          ),
        ),
      ),
    );
  }
}
