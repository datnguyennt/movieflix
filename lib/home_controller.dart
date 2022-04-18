import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:movie_flix/util/common/common.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/account/account_user.dart';
import 'util/constants/locale_keys.dart';

class HomeController extends GetxController {
  RxString userName = "".obs;
  RxString userEmail = "".obs;
  RxString avatar = "".obs;

  List<String> scopes = [
    //drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveFileScope,
    //drive.DriveApi.driveReadonlyScope,
    "https://www.googleapis.com/auth/userinfo.profile",
    "https://www.googleapis.com/auth/userinfo.email"
  ];

  bool loginStatus = false;
  RxBool isUpload = false.obs;

  // final client = http.Client();
  @override
  void onInit() async {
    super.onInit();
  }

  prompt(String url) {
    launch(url);
  }

  // signIn() async {
  //   // discover the metadata of the google OP
  //   var issuer = await Issuer.discover(Issuer.google);
  //
  //   // create a client
  //   var client = Client(issuer, Const.clientIdMacOs,
  //       clientSecret: Const.clientSecret);
  //
  //   // create an authenticator
  //   var authenticator =
  //   Authenticator(client, scopes: scopes, urlLancher: prompt);
  //
  //   // starts the authentication
  //   var c = await authenticator.authorize();
  //
  //   // return the user info
  //   var userInfo = await c.getUserInfo();
  //
  //   log(userInfo.toJson().toString());
  //   log(userInfo.familyName ?? "");
  //   log(userInfo.givenName ?? "");
  //   log(userInfo.email ?? "");
  //   log(userInfo.phoneNumber ?? "");
  //   log(userInfo.picture.toString());
  // }
  //
  // Future<UserInfo> _userFromCredential(Credential c) async {
  //   if (c.refreshToken != null) return await c.getUserInfo();
  //
  //   return _userFromResponse(c.response!);
  // }
  //
  // UserInfo _userFromResponse(Map<String, dynamic> response) =>
  //     UserInfo.fromJson({
  //       "given_name": "",
  //       "family_name": "",
  //       "email": json.encode(response)
  //     });
  //
  // Future<void> getUserInfo()async{
  //   var user = signIn();
  //   Logger.info(user.familyName ?? "");
  //   Logger.info(user.givenName ?? "");
  //   Logger.info(user.email ?? "");
  //   Logger.info(user.phoneNumber ?? "");
  //   Logger.info(user.picture.toString());
  // }

// Future<void> fetchFiles() async {
//   var hlp = OAuth2Helper(
//     GoogleOAuth2Client(
//         redirectUri: 'com.teranet.app:/oauth2redirect',
//         customUriScheme: 'com.teranet.app'),
//     grantType: OAuth2Helper.AUTHORIZATION_CODE,
//     clientId: 'XXX-XXX-XXX',
//     clientSecret: 'XXX-XXX-XXX',
//     scopes: ['https://www.googleapis.com/auth/drive.readonly'],
//   );
//
//   var resp = await hlp.get('https://www.googleapis.com/drive/v3/files');
//
//   print(resp.body);
// }
  String folderName = "Ảnh heo";

  Future<void> loginGoogle() async {
    var issuer = await Issuer.discover(Issuer.google);
    var client = Client(issuer, LocaleKeys.clientIdMacOs, clientSecret: LocaleKeys.clientSecret);

    // create an authenticator
    var authenticator = Authenticator(client,
        scopes: LocaleKeys.scopes,
        port: 4000, urlLancher: prompt);

    // starts the authentication
    var c = await authenticator.authorize();
    AccountUser accountUser = AccountUser.fromJson(c.response!);
    log(accountUser.accessToken ?? "");
    log(accountUser.expiresIn.toString());
    log(accountUser.refreshToken ?? "");
    log(accountUser.tokenType ?? "");

    // var client = await obtainCredential();
    // // AccessCredentials token =
    // //     AccessCredentials.fromJson(client.credentials.toJson());
    // //log(token.accessToken.data);
    // log(client.credentials.toJson().toString());
    // log(
    //     CommonUtil.parseDateToString(token.accessToken.expiry, 'HH:mm'));
    // log(token.accessToken.hasExpired.toString());
    // tokenData.value = token.accessToken.data;

    // var url = Uri.parse('https://www.googleapis.com/oauth2/v3/userinfo');
    // final response = await http.get(url, headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer ${token.accessToken.data}',
    // });
    // if (response.statusCode == 200) {
    //   Map<String, dynamic> body = jsonDecode(response.body);
    //   AccountUser user = AccountUser.fromJson(body);
    //   userName.value = "${user.familyName ?? ""} ${user.givenName ?? ""}";
    //   userEmail.value = "${user.familyName ?? ""} ${user.givenName ?? ""}";
    // }
    //okenData.value = token.accessToken.data;
  }

  // Future<AuthClient> obtainCredential() async {
  //   final client = http.Client();
  //   try {
  //     return await clientViaUserConsent(
  //       clientId,
  //       scopes,
  //
  //       // client,
  //       prompt,
  //
  //     );
  //   } finally {
  //     client.close();
  //   }
  // }

  RxString tokenData = "".obs;

  // Future<void> createFolder() async {
  //   if (CommonUtil.isEmpty(tokenData.value)) {
  //     var client = await obtainCredential();
  //     //AccessCredentials token = AccessCredentials.fromJson(client.credentials.toJson());
  //     Logger.info(client.credentials.accessToken.data);
  //     Logger.info(client.credentials.accessToken.expiry.toString());
  //     Logger.info(client.credentials.accessToken.hasExpired.toString());
  //     Logger.info(client.credentials.accessToken.data.toString());
  //     tokenData.value = client.credentials.accessToken.data;
  //     Logger.info("errror");
  //   }
  //   Map<String, String> header = {
  //     'Authorization': 'Bearer ${tokenData.value}',
  //     'X-Goog-AuthUser': '0',
  //   };
  //   //pass header to http client
  //   final client2 = GoogleAuthClient(header);
  //   final driveApi = drive.DriveApi(client2);
  //   var folder = drive.File();
  //   folder.name = folderName;
  //   folder.mimeType = "application/vnd.google-apps.folder";
  //   final folderCreation = await driveApi.files.create(folder);
  //   Logger.info("Folder ID: ${folderCreation.id}");
  // }

  // Future<String?> createFolder() async {
  //   var client = await getHttpClient();
  //   var gdrive = drive.DriveApi(client);
  //   // Create a folder
  //   var folder = drive.File();
  //   folder.name = folderName;
  //   folder.mimeType = "application/vnd.google-apps.folder";
  //   final folderCreation = await gdrive.files.create(folder);
  //   Logger.error("Folder ID: ${folderCreation.id}");
  //
  //   return folderCreation.id;
  // }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
