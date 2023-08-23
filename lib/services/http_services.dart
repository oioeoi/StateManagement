import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:themeDataAndBloc/models/http_model.dart';

class HttpService {
  static Future<HttpModel> connectAPI(String name, String job) async {
    var url = Uri.parse("https://reqres.in/api/users");
    var response = await http.post(url,
        headers: {
          'Content-Type':
              'application/json', // Set the content type for the request
        },
        body: jsonEncode({
          "name": name,
          "job": job,
        }));
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return HttpModel(
        id: data["id"],
        name: data["name"],
        job: data["job"],
        createAt: data["createdAt"],
      );
    } else {
      throw Exception('Failed to create user');
    }
  }
}
