import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'https://arrival365.com/api';
  final String urllocal = 'http://127.0.0.1:8000/api';
  final String imageget = 'https://arrival365.com/public/img';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'))['token'];
    print(token);
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  loaclauthData(data, apiUrl) async {
    var fullUrl = urllocal + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    //await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  Future<http.StreamedResponse> patchImage(
      String url, String filepath, int id) async {
    url = formater(url);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("image", filepath));
    request.fields['id'] = id.toString();
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    print(request);
    var response = request.send();
    return response;
  }

  String formater(String url) {
    return _url + url;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
