import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:prueba_humberto/User/model/user_model.dart';

class UsersRepository {
  Future<List<UserModel>> fetchUsers() async {
    var url = Uri.https(
        "us-central1-ingreso1-7fb4e.cloudfunctions.net", "/getAllUsers");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      final List<Map<String, dynamic>> usersList =
          List<Map<String, dynamic>>.from(jsonResponse);
      return List.generate(
        usersList.length,
        (i) => UserModel(
          uid: usersList[i]['uid'],
          displayName: usersList[i]['displayName'],
          email: usersList[i]['email'],
          providerId: usersList[i]['providerId'],
        ),
      );
    } else {
      return List.generate(
        0,
        (i) => UserModel(
          uid: '',
          displayName: '',
          email: '',
          providerId: '',
        ),
      );
    }
  }
}
