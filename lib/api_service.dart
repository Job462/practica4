import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class ApiService {
  final String apiUrl;

  ApiService({required this.apiUrl});

  Future<List<UserModel>> getUsers({required int offset, required int limit}) async {
    final response = await http.get(
      Uri.parse('$apiUrl/api/users?offset=$offset&limit=$limit'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
