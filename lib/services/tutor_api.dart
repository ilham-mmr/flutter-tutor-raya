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

    // // convert filters to data map
    // var dataFilters = {
    //   "minPrice": filters?["minPrice"] ?? "",
    //   "maxPrice": filters?["minPrice"] ?? "",
    //   "date": filters?["date"].toString() ?? "",
    //   "category": filters?["category"].toString() ?? ""
    // };

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

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Tutor> tutors =
          data.map<Tutor>((item) => Tutor.fromJson(item)).toList();

      return tutors;
    }
    return <Tutor>[];
  }

  getUserFavoriteTutors() async {
    var url = Uri.parse(API_ROOT + "/tutor-favorites");
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Accept': 'application/json'
      },
    );
    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      // print(data['7']['is_favorite'] == 1);
      return data;
    }

    return null;
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
