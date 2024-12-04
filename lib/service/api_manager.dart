import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:knovator/service/endpoints.dart';
import 'package:knovator/view/widget/custom_toast.dart';

class ApiManager {
  static final ApiManager _instance = ApiManager._internal();

  ApiManager._internal();

  static ApiManager get instance => _instance;

  Future<Response> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse("${Endpoints.baseUrl}$endpoint"));
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on ClientException {
      CustomToast.instance.showMsg("No internet connection. Please check your network settings.");
      throw Exception('No Internet Connection');
    } on SocketException {
      CustomToast.instance.showMsg("No internet connection. Please check your network settings.");
      throw Exception('No Internet Connection');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
