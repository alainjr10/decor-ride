import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailProvider = StateProvider<String>((ref) => '');

final passwordProvider = StateProvider<String>((ref) => '');

final togglePasswordVisibilityProvider = StateProvider<bool>((ref) => true);
