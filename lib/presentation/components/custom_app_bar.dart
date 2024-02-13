import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;

  CustomAppBar({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        title,
        style: GoogleFonts.poppins(
            color: Colors.white
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}