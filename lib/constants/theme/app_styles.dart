import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppStyles{


  static TextStyle W500Black20 = GoogleFonts.inter(
    color: AppColors.primaryColorDark,
    fontWeight: FontWeight.w500,
    fontSize: 20,

  );

  static TextStyle W500Black24 =GoogleFonts.inter(
    color: AppColors.primaryColorDark,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  static TextStyle W700Black16 = GoogleFonts.inter(
    color: AppColors.primaryColorDark,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
}