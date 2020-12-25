import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Model/DonationData.dart';

const SERVER_IP = 'https://blood-donation-backend-se231.herokuapp.com/api';
final storage = FlutterSecureStorage();

Future<String> attemptLogIn(String email, String password) async {
  print('Hi');
  Map<String, String> headers = {'Content-Type': 'application/json'};
  final msg = jsonEncode({"email": email, "password": password});
  var res =
      await http.post("$SERVER_IP/auth/login", body: msg, headers: headers);
  print(res.statusCode);

  if (res.statusCode == 200) {
    Map<String, dynamic> response = jsonDecode(res.body);

    String jwt = "Bearer " + response['token'];
    return jwt;
  }
  return null;
}

Future<List<DonationData>> getData({String jwtToken}) async {
  Map<String, String> headers = {};
  headers['Content-Type'] = 'application/json';
  headers['Authorization'] = jwtToken;

  var res = await http.get(
    "$SERVER_IP/donation/list/",
    headers: headers
  );
  print(res.statusCode);
  if (res.statusCode == 200) {
    print(res.body);
    List<DonationData> response;
    response = (jsonDecode(res.body) as List)
        .map((i) => DonationData.fromJson(i))
        .toList();

    return response;
  }
  return null;
}
