import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = const Color(0xDD000000);
  static const Color loginGradientEnd = const Color(0xDD000000);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [10.0, 10.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}