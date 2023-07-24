import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Creattext extends StatelessWidget {
  final String text;
  final bool big;

  Creattext({super.key, required this.text, this.big = true});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.outfit(
          fontWeight: FontWeight.w500,
          fontSize: big ? 35 : 18,
          color: big ? Colors.black : Colors.grey),
    );
  }
}
