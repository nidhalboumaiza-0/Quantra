import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

PreferredSizeWidget simpleAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(
        Icons.arrow_back,
        color: primaryTextColor,
      ),
    ),
  );
}
