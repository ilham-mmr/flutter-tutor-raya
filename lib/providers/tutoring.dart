import 'package:flutter/material.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/services/tutoring_api.dart';

class TutoringProvider with ChangeNotifier {
  // AuthProvier
  AuthProvider authProvider;
  //  ApiService apiService;
  late TutoringService tutoringService;

  TutoringProvider(this.authProvider) {
    tutoringService = TutoringService(authProvider);
  }

  bookTutoring(int tutoringId) async {
    var data = await tutoringService.bookTutoring(tutoringId);
    return data;
  }

  getBookedLessons() async {
    var data = await tutoringService.getBookedLessons();
    return data;
  }
}
