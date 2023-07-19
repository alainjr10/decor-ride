// create an extension of buildcontext for the theme
// this will allow us to access the theme data from anywhere in the app

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension Spacing on num {
  // vertical spacing
  SizedBox get vGap => SizedBox(height: toDouble().h);
  SizedBox get hGap => SizedBox(width: toDouble().w);
}