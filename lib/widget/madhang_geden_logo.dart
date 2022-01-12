import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MadhangGedenLogo extends StatelessWidget {
  const MadhangGedenLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'images/madhang_geden_logo2.png',
          width: 40,
          height: 40,
        ),
        Text(
          'Madhang Geden',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
