class ResponseModel {
  ResponseModel({
    this.error,
  });

  final ResponseModelError? error;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    error: json["error"] == null ? null : ResponseModelError.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error!.toJson(),
  };
}

class ResponseModelError {
  ResponseModelError({
    this.errors,
    this.code,
    this.message,
  });

  final List<ErrorElement>? errors;
  final String? code;
  late final String? message;

  factory ResponseModelError.fromJson(Map<String, dynamic> json) => ResponseModelError(
    errors: json["errors"] == null ? null : List<ErrorElement>.from(json["errors"].map((x) => ErrorElement.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "errors": errors == null ? null : List<dynamic>.from(errors!.map((x) => x.toJson())),
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}

class ErrorElement {
  ErrorElement({
    this.domain,
    this.reason,
    this.message,
    this.locationType,
    this.location,
  });

  late final String? domain;
  final String? reason;
  final String? message;
  final String? locationType;
  final String? location;

  factory ErrorElement.fromJson(Map<String, dynamic> json) => ErrorElement(
    domain: json["domain"] == null ? null : json["domain"],
    reason: json["reason"] == null ? null : json["reason"],
    message: json["message"] == null ? null : json["message"],
    locationType: json["locationType"] == null ? null : json["locationType"],
    location: json["location"] == null ? null : json["location"],
  );

  Map<String, dynamic> toJson() => {
    "domain": domain == null ? null : domain,
    "reason": reason == null ? null : reason,
    "message": message == null ? null : message,
    "locationType": locationType == null ? null : locationType,
    "location": location == null ? null : location,
  };
}
