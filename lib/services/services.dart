import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('https://reqres.in/api/login');
    final body = {
      'email': email,
      'password': password,
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': jsonDecode(response.body)['error'] ?? 'Login failed!'};
      }
    } catch (e) {
      return {'error': 'Something went wrong. Please try again.'};
    }
  }
}
