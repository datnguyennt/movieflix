class ProdAppMovieEnvironment{
  final baseUrl = "https://www.googleapis.com";
  final baseApi = "/oauth2";
  final baseVersion = "/v3";
  final receiveTimeout = 2 * 60 * 1000;
  final connectTimeout = 2 * 60 * 1000;

  String get domainApi => "$baseUrl$baseApi$baseVersion";
}

final appEnvironment = ProdAppMovieEnvironment();

class UrlApi{
  static const getUserInfo = "/userinfo";

}