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

  Future<List<Tutor>> getTutors(
      {int? limit, String? keyword, Map<String, dynamic>? filters}) async {
    String url = API_ROOT + "/tutors?";
    if (limit != null) {
      url += 'limit=$limit&';
    }
    if (keyword != null) {
      url += 'keyword=$keyword&';
    }

    filters?.forEach((key, value) {
      if (value != "") {
        url += '$key=$value&';
      }
    });

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

      return tutors;
    }
    return <Tutor>[];
  }

  getUserFavoriteTutors({bool? withDetails}) async {
    var url = API_ROOT + "/tutor-favorites?";
    if (withDetails != null && withDetails) {
      url += 'with_details=true';
    }
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Accept': 'application/json'
      },
    );
    Map<String, dynamic> data = {};

    try {
      if (response.statusCode == 200) {
        if (withDetails != null && withDetails) {
          return jsonDecode(response.body)["data"];
        }
        data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      return null;
    }
  }

  removeRemoteFavoriteTutor(String id) async {
    var url = Uri.parse(API_ROOT + "/tutor-favorites/$id");

    final response = await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      return true;
    }
    return false;
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

      Tutor tutor = Tutor.fromJson(data);
      var tutorings = data["tutorings"]
          .map<Tutoring>((item) => Tutoring.fromJson(item))
          .toList();
      tutor.tutorings = tutorings;

      return tutor;
    }
    return Future.error('No data');
  }
}
