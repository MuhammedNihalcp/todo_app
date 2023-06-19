import 'package:flutter/material.dart';

import '../../core/colors.dart';

class CircularIndicatorWidget extends StatelessWidget {
  const CircularIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: authbuttoncolor,
      color: colorWhite,
    );
  }
}
