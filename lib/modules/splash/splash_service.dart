import 'package:get/get.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/app_pages.dart';
import '../../util/common/common_util.dart';
import '../../util/common/logger.dart';
import '../../util/constants/locale_keys.dart';

class SplashService extends GetxService {
  late String accessToken;

  final memo = AsyncMemoizer<void>();

  Future<void> init() {
    return memo.runOnce(_initFunction);
  }

  Future<bool> isLoggedIn() async {
    final _store = GetStorage();
    accessToken = _store.read(UserKey.accessToken) ?? "";
    return !CommonUtil.isEmpty(accessToken);
  }

  Future<void> _initFunction() async {
    //simulate some long running operation
    await Future.delayed(const Duration(seconds: 3), () async {
      bool isLogin = await isLoggedIn();
      if (isLogin) {
        // await CommonUtil.getUserAccount();
        // await Global.getBotList();
        // await GloBal.getProject();
        Logger.info("user logged in");
        // Get.offAllNamed(Routes.WELCOME_PAGE);
      } else {
        Logger.info("usser not logged in");
        await CommonUtil.loginGoogle();
        Get.offAllNamed(Routes.HOME);
      }
    });
    //cancel the timer once we are done
  }
}
