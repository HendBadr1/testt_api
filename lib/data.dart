import 'package:dio/dio.dart';

import 'model.dart';


class ContactRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> sendContactRequest(ContactRequestModel model) async {
    const String url = "https://portfolio-app-production-817d.up.railway.app/api/v1/request/contact";

    final response = await _dio.post(
      url,
      data: model.toJson(),
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception("Failed to send contact request: ${response.statusCode}");
    }
  }
}
