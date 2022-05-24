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

  /*
   whenever wa want to get data from the search and home screen for tutor cards.
   we check against the retrieved data and favoritedData['id']
   if it's null then make it false, if it's favorited then make it true
   
   */

  // toggleFavorite(int userId, tutorId) {
  // call tutorService.togglefavorite(userId, tutorId);
  // make product model have withchangenotifier
  // add the relevant method?
  // }
}
