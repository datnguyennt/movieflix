import 'package:get/get.dart';
import 'package:movie_flix/modules/splash/splash_service.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashService>(
          () => SplashService(),
    );
    // TODO: implement dependencies
  }

}