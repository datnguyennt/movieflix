import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import '../../data/url_api.dart';
import '../../models/account/account_user.dart';
import '/util/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'global.dart';

class CommonUtil {
  static bool isEmpty(obj) {
    if (obj is String) return obj.isEmpty;
    if (obj is List) return obj.isEmpty || obj.length == 0;
    return obj == null;
  }

  static prompt(String url) {
    launch(url);
  }

  // static Future<void> loginGoogle() async {
  //   final clientId =
  //       ClientId(LocaleKeys.clientIdMacOs, LocaleKeys.clientSecret);
  //
  //   AuthClient authClient =
  //       await clientViaUserConsent(clientId, LocaleKeys.scopes, prompt);
  //   AccessCredentials accessCredentials =
  //       AccessCredentials.fromJson(authClient.credentials.toJson());
  //   log("token " + authClient.credentials.toJson().toString());
  //   log("access token " + accessCredentials.accessToken.data);
  //   log("expire token " + accessCredentials.accessToken.expiry.toString());
  //   log("refresh token " + accessCredentials.refreshToken.toString());
  //   Global.refreshToken = accessCredentials.refreshToken.toString();
  //   Global.accessToken = accessCredentials.accessToken.data.toString();
  // }
  static Future<bool> loginGoogle() async {
    var issuer = await Issuer.discover(Issuer.google);
    var client = Client(issuer, LocaleKeys.clientIdMacOs,
        clientSecret: LocaleKeys.clientSecret);

    // create an authenticator
    var authenticator = Authenticator(client,
        scopes: LocaleKeys.scopes, port: 4000, urlLancher: prompt);

    // starts the authentication
    var c = await authenticator.authorize();
    AccountUser accountUser = AccountUser.fromJson(c.response!);
    log(accountUser.accessToken ?? "");
    log(accountUser.expiresIn.toString());
    log(accountUser.refreshToken ?? "");
    log(accountUser.tokenType ?? "");
    if (!CommonUtil.isEmpty(accountUser.accessToken) &&
        !CommonUtil.isEmpty(accountUser.refreshToken)) {


      Global.refreshToken = accountUser.refreshToken.toString();
      Global.accessToken = accountUser.accessToken.toString();
      return true;
    } else {
      return false;
    }

    // log("token " + author.toJson().toString());
    // log("access token " + accessCredentials.accessToken.data);
    // log("expire token " + accessCredentials.accessToken.expiry.toString());
    // log("refresh token " + accessCredentials.refreshToken.toString());
  }

  static Future<void> saveUserLogin({required AccountUser accountUser}) async {
    Global.user = accountUser;
    final _store = GetStorage();
    _store.write(UserKey.accessToken, accountUser.accessToken ?? "");
    _store.write(UserKey.givenName, accountUser.givenName ?? "");
    _store.write(UserKey.familyName, accountUser.familyName ?? "");
    _store.write(UserKey.picture, accountUser.picture ?? "");
    _store.write(UserKey.expiresIn, accountUser.expiresIn ?? "");
    _store.write(UserKey.name, accountUser.name ?? "");
    _store.write(UserKey.email, accountUser.email ?? "");
    _store.write(UserKey.scope, accountUser.scope ?? "");
    _store.write(UserKey.refreshToken, accountUser.refreshToken ?? "");
  }

  static Future<AccountUser?> loadUser() async {
    final _store = GetStorage();
    AccountUser accountUser = AccountUser();
    accountUser.name = _store.read(UserKey.name);
    accountUser.email = _store.read(UserKey.email);
    accountUser.picture = _store.read(UserKey.picture);
    accountUser.accessToken = _store.read(UserKey.accessToken);
    accountUser.familyName = _store.read(UserKey.familyName);
    accountUser.givenName = _store.read(UserKey.givenName);
    accountUser.expiresIn = _store.read(UserKey.expiresIn);
    return accountUser;
  }

  static Future<void> clearUser() async {
    Global.user = null;
    final _store = GetStorage();
    await _store.remove(UserKey.accessToken);
    await _store.remove(UserKey.familyName);
    await _store.remove(UserKey.email);
    await _store.remove(UserKey.expiresIn);
    await _store.remove(UserKey.givenName);
    await _store.remove(UserKey.familyName);
    await _store.remove(UserKey.picture);
    await _store.remove(UserKey.scope);
    await _store.remove(UserKey.refreshToken);
  }

  static openBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
