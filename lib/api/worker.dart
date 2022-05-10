import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'urls.dart';

class Api {
  static Future<Map> getCategories() async {
    http.Response resp;

    try {
      resp = await http.get(Urls.categories);
    } catch (e) {
      throw Exception("Unable to load data from server"); // throw error if network timed out, or unable to access internet.
    }

    if (resp.statusCode == 200) {
      // OK
      try {
        return jsonDecode(resp.body);
      } catch (e) {
        throw Exception("Unable to read server response"); // if server responds in any format other than JSON.
      }
    } else if (resp.statusCode >= 500) {
      // Webapp down, or unable to handle request
      throw Exception("Server seems to be down, please try again later");
    }
    throw Exception("Error ${resp.statusCode}, Please contact developer for more."); // Somthing is wrong with the request.
  }

  // Send details
  static Future<int> submitDetails(File file, String filename, String name, String email, String password, String gender, String date) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Urls.submit,
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'image',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({"name": name, "email": email, "password": "12345", "gender": gender, "dob": date, "user_status": "active"});
    print("request: " + request.toString());
    var res = await request.send();
    print("This is response:" + res.toString());
    return res.statusCode;
  }

  // temp data
  static Future<List<Map>> temp() async {
    return List.generate(
        20,
        (index) => {
              "name": "Salon Name",
              "thumbnail": "assets/images/image${index.isEven ? 2 : 4}.png",
              "location": "Near location name",
              "distance": "2 miles",
              "rating": 4.5,
            });
  }
}
