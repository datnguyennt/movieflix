import 'package:get/get.dart';
import 'package:movie_flix/modules/home/bindings/home_binding.dart';
import 'package:movie_flix/modules/splash/splash_page.dart';

import '../modules/home/views/home_view.dart';
import '../modules/splash/binding/splash_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
