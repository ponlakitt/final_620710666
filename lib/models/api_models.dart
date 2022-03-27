class APIModels{
  final String status;
  final String? message;
  final dynamic data;

  APIModels({
    required this.status,
    required this.message,
    required this.data,
  });

  factory APIModels.fromJson(Map<String, dynamic> json) {
    return APIModels(
      status: json["status"],
      message: json["message"],
      data: json["data"],
    );
  }
}