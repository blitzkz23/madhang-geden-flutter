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
          width: 60,
          height: 60,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          'Madhang Geden',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
