import 'package:divyanga/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle letterTracingTextStyle = GoogleFonts.comicNeue(
    textStyle: const TextStyle(
        fontSize: 300,
        fontWeight: FontWeight.w800,
        color: Colors.white
    )
);

final TextStyle letterTraceTextStyle = GoogleFonts.comicNeue(
    textStyle: const TextStyle(
        fontSize: 500,
        fontWeight: FontWeight.w800,
        color: Colors.grey
    )
);

final TextStyle headerTextStyle = GoogleFonts.comicNeue(
    textStyle: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        color: Colors.black
    )
);

final TextStyle infoTextStyle = GoogleFonts.comicNeue(
    textStyle: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: Colors.white
    )
);

final TextStyle inputTextStyle = GoogleFonts.comicNeue(
    textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor
    )
);

final TextStyle labelTextStyle = GoogleFonts.comicNeue(
    textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white
    )
);

final ButtonStyle flatButtonStyle = OutlinedButton.styleFrom(
  //0xFFFBFbFB
  backgroundColor: Colors.orangeAccent,
  side: const BorderSide(color: Colors.black, width: 1),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  //textStyle: GoogleFonts.poppins(textStyle:const TextStyle(fontSize: 16, color: primaryColor,  fontWeight: FontWeight.w500)),
);

const BoxDecoration gradient =  BoxDecoration(
    gradient: LinearGradient(
      colors: [primaryColor, secondaryColor],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    )
);

const BoxDecoration curvedEdges = BoxDecoration(
  color: Colors.black54,
  borderRadius: BorderRadius.all(Radius.circular(25)),
);

const BoxDecoration containerBox = BoxDecoration(
  color: secondaryColor,
  borderRadius: BorderRadius.all(Radius.circular(25)),
);

const BoxDecoration curvedTops = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
);