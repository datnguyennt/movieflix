import '../../models/account/account_user.dart';
import '../base_request.dart';
import '../url_api.dart';

class LoginRepository{

  final BaseRequest _request = BaseRequest(base: appEnvironment.domainApi);

  Future<AccountUser> getAccountInfo(String token) async {
    var url = UrlApi.getUserInfo;
    var res = await _request.requestBearerApi(
        method: MethodType.POST, url: url, param: {"token": token});
    return res;
  }
}