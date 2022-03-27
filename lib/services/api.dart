import "dart:convert";
import 'package:http/http.dart' as http;

class Api {
  static const BASE_URL = 'https://cpsu-test-api.herokuapp.com';

  Future<dynamic> fetch(
      String endPoint, {
        Map<String, dynamic>? queryParams
      }) async {
    var url = Uri.parse('$BASE_URL/$endPoint');
    print(url);
    final response = await http.get(url, headers: {'id': '620710666'});
    if(response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);
      print(jsonBody);
    }
    else {
      throw "Server connection failed";
    }
  }
  }