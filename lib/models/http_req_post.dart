import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpStatefull {
  final String id, name, job, ceateAt;
  HttpStatefull({
    this.id = '',
    this.name = '',
    this.job = '',
    this.ceateAt = '',
  });
  static Future connectAPI(String name, job) async {
    var response = await http.post(
      Uri.parse("https://reqres.in/api/users"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "job": job,
      }),
    );
    Map obj = jsonDecode(response.body);
  }
}
