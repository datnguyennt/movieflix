part of 'app_pages.dart';

abstract class Routes {
  static const SPLASH = '/splash';
  static const SHAREIMAGE = '/shareimage';
  static const CITY_SEARCH = '/citySearch';
  static const CROPIMAGE = '/cropImage';
  static const RESULTCROP = '/resultCropImage';
  static const ERROR = '/error';

  static const HOME = _Paths.HOME;
  static const HOMEWEATHER = _Paths.HOME + _Paths.HOMEWEATHER;

  static const PROFILE = _Paths.HOME + _Paths.PROFILE;
  static const SETTINGS = _Paths.SETTINGS;

  static const PRODUCTS = _Paths.HOME + _Paths.PRODUCTS;

  static const LOGIN = _Paths.LOGIN;
  static const SELECTINGPROJECT = _Paths.SELECTINGPROJECT;

  static const MATERIAL = _Paths.MATERIAL;
  // static const DASHBOARD = _Paths.HOME + _Paths.DASHBOARD;

  Routes._();
  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$LOGIN?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';

  static String SELECTED_THEN(String afterSuccessfulLogin) =>
      '$SELECTINGPROJECT?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';

  static String PRODUCT_DETAILS(String productId) => '$PRODUCTS/$productId';
}

/* * Routes cho app
* Dùng được để deep link
! Giá trị truyền vào giống với uri
? https://github.com/jonataslaw/getx/blob/master/documentation/en_US/route_management.md
* */

abstract class _Paths {
  static const HOME = '/home';
  static const SPLASH = '/splash';
  static const HOMEWEATHER = '/homeWeather';
  static const PRODUCTS = '/products';
  static const PROFILE = '/profile';
  static const PRODUCT_DETAILS = '/:productId';
  static const LOGIN = '/login';
  static const SETTINGS = '/settings';
  static const SELECTINGPROJECT = '/sliverappbar';
  static const MATERIAL = '/material';
}
