class AccountUser {
  String? accessToken;
  int? expiresIn;
  String? refreshToken;
  String? scope;
  String? name;
  String? givenName;
  String? familyName;
  String? picture;
  String? email;
  String? tokenType;

  AccountUser({
    this.accessToken,
    this.scope,
    this.picture,
    this.email,
    this.familyName,
    this.givenName,
    this.name,
    this.expiresIn,
    this.refreshToken,
    this.tokenType,
  });

  AccountUser.fromJson(Map<dynamic, dynamic> json) {
    accessToken = json['access_token'] ?? null;
    expiresIn = json['expires_in'] ?? null;
    refreshToken = json['refresh_token'] ?? null;
    scope = json['scope'] ?? null;
    tokenType = json['token_type'] ?? null;
    name = json['name'] ?? null;
    givenName = json['given_name'] ?? null;
    familyName = json['family_name'] ?? null;
    picture = json['picture'] ?? null;
    email = json['email'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['expires_in'] = this.expiresIn;
    data['refresh_token'] = this.refreshToken;
    data['scope'] = this.scope;
    data['token_type'] = this.tokenType;
    data['given_name'] = this.givenName;
    data['family_name'] = this.familyName;
    data['picture'] = this.picture;
    data['email'] = this.email;
    data['name'] = this.name;
    return data;
  }
}
