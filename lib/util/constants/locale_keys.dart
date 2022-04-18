import 'package:googleapis/drive/v3.dart' as drive;
abstract class LocaleKeys {
  static const hello = "hello";
  static const settings = "setting";
  static const language = "language";

  static const theme = "theme";
  static const system = "system";
  static const dark = "dark";
  static const light = "light";
  static const not_found = "Not found.";
  static const error = "Error";
  static const unknown_error = "Unknown_error";

  //error description
  static const request_send_timeout = "request_send_timeout";
  static const request_cancelled = "request_cancelled";
  static const request_connect_timeout = "request_connect_timeout";
  static const no_internet = "no_internet";
  static const request_receive_timeout = "request_receive_timeout";

  static const String CLIENT_ID = "528204460219-mb7rmdb6gak7fg9reo59uoaaufhdgpuj.apps.googleusercontent.com";

  static const clientIdMacOs = "528204460219-0cmslce6qqhoerglm7ogg5e17dcaf90v.apps.googleusercontent.com";
  static const clientIdAndroid = "326701694393-okkbpnjh6a1esjugqstidnstcjpoid1i.apps.googleusercontent.com";
  static const clientSecret = "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";

  static const List<String> scopes = [
    //drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveFileScope,
    //drive.DriveApi.driveReadonlyScope,
    "https://www.googleapis.com/auth/userinfo.profile",
    "https://www.googleapis.com/auth/userinfo.email"
  ];
}

abstract class UserKey {
  static const String accessToken = "access_token";
  static const String expiresIn = "expires_in";
  static const String refreshToken = "refresh_token";
  static const String scope = "scope";
  static const String tokenType = "token_type";
  static const String name = "name";
  static const String givenName = "given_name";
  static const String familyName = "family_name";
  static const String picture = "picture";
  static const String email = "email";
}
