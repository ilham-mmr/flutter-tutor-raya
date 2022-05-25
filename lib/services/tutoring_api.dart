import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class TutoringService {
  AuthProvider authProvider;
  late String token;

  TutoringService(this.authProvider) {
    token = authProvider.token;
  }

  bookTutoring(int tutoringId) async {
    String url = API_ROOT + "/booking";
    if (authProvider.user?.id == null) {
      return;
    }
    final response = await http.post(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'Accept': 'application/json'
    }, body: {
      "tutoring_id": tutoringId.toString(),
      "user_id": authProvider.user!.id.toString(),
    });

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  getBookedTutorings() {}
}
