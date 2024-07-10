import 'package:http/http.dart' as http;

class ApiResponse<T extends Object?> {
  final T data;
  final http.Response response;
  final int? statusCode;

  const ApiResponse({
    required this.data,
    required this.response,
    this.statusCode = -1,
  });

  @override
  String toString() => 'ApiResponse{data: $data, response: $response, statusCode: $statusCode}';
}
