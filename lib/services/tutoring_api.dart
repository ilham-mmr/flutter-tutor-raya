import 'package:tutor_raya_mobile/models/lesson.dart';
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

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  getBookedLessons() async {
    if (authProvider.user?.id == null) {
      return;
    }
    String url =
        API_ROOT + "/lessons?user_id=${authProvider.user!.id.toString()}";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      var lessons =
          data["lessons"].map<Lesson>((item) => Lesson.fromJson(item)).toList();

      return lessons;
    }

    return Future.error('No data');
  }
}
