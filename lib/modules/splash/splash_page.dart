import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_flix/modules/splash/splash_service.dart';
import 'package:movie_flix/util/common/common.dart';

import '../../routes/app_pages.dart';
import '../../util/constants/constants.dart';

class SplashPage extends StatelessWidget {
  final SplashService service = Get.put(SplashService());
  @override
  Widget build(BuildContext context) {
    service.init();
    return const Center(child: CircularProgressIndicator());
  }
}
