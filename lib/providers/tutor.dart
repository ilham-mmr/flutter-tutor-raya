import 'package:flutter/material.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/services/tutor_api.dart';

class TutorProvider with ChangeNotifier {
  // AuthProvier
  AuthProvider authProvider;
  //  ApiService apiService;
  late TutorService tutorService;

  TutorProvider(this.authProvider) {
    tutorService = TutorService(authProvider);
  }

  getTutors([int? limit]) async {
    var data = await tutorService.getTutors(limit);
    return data;
  }

  getTutorDetail(int? id) async {
    var data = await tutorService.getTutorDetail(id);
    return data;
  }
}
