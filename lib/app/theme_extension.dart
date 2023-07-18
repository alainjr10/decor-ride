// create an extension of buildcontext for the theme
// this will allow us to access the theme data from anywhere in the app

import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}
