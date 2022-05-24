import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/models/tutoring.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class TutorService {
  AuthProvider authProvider;
  late String token;

  TutorService(this.authProvider) {
    token = authProvider.token;
  }

  Future<List<Tutor>> getTutors([int? limit]) async {
    String url = API_ROOT + "/tutors";
    if (limit != null) {
      url += '?limit=$limit';
    }
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Tutor> tutors =
          data.map<Tutor>((item) => Tutor.fromJson(item)).toList();
      // tutors.forEach((element) {
      //   print(element.minPrice);
      // });
      return tutors;
    }
    return <Tutor>[];
  }

  getTutorDetail(int? id) async {
    if (id == null) {
      return;
    }
    String url = API_ROOT + "/tutors/$id" + "?with_tutorings=yes";
    // String url = API_ROOT + "/tutors/" + id.toString() + "?with_tutorings=yes";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      // print(data);
      // var tutoringsData = data["tutorings"];
      // tutoringsData.forEach((element) {
      //   print(element["title"]);
      // });
      Tutor tutor = Tutor.fromJson(data);
      var tutorings = data["tutorings"]
          .map<Tutoring>((item) => Tutoring.fromJson(item))
          .toList();
      // print(tutorings);
      tutor.tutorings = tutorings;

      // print(tutoringsData);
      // tutoringsData.forEach((element) {
      //   print(element);
      // });
      return tutor;
    }
    return Future.error('No data');
  }
}
