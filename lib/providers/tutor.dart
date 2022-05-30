import 'package:flutter/material.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/services/tutor_api.dart';

class TutorProvider with ChangeNotifier {
  // AuthProvier
  AuthProvider authProvider;
  //  ApiService apiService;
  late TutorService tutorService;
  List<Tutor> _tutors = [];
  List<Tutor> _favoriteTutors = [];
  get tutors {
    return _tutors;
  }

  get favoriteTutors {
    return _favoriteTutors;
  }

  TutorProvider(this.authProvider) {
    tutorService = TutorService(authProvider);
  }

  getTutors([int? limit]) async {
    var data = await tutorService.getTutors(limit: limit);
    var favoriteData = await tutorService.getUserFavoriteTutors();
    // final List<Tutor> loadedProducts = [];
    for (var tutor in data) {
      // print(favoriteData['${tutor.id}']['is_favorite']);
      // if (favoriteData['${tutor.id}']['is_favorite'] == 1) {
      //   addFavoriteTutor(tutor);
      // }
      tutor.isFavorite = favoriteData['${tutor.id}'] == null
          ? false
          : favoriteData['${tutor.id}']['is_favorite'] == 1
              ? true
              : false;
    }
    return data;
  }

  addFavoriteTutor(Tutor tutor) {
    var foundTutor =
        _favoriteTutors.firstWhere((element) => element.id == tutor.id);
    if (foundTutor == null) {
      _favoriteTutors.add(tutor);
      notifyListeners();
    }
  }

  removeFavoriteTutor(Tutor tutor) {
    var filteredFavoriteTutors =
        _favoriteTutors.where((element) => !(element.id == tutor.id)).toList();
    _favoriteTutors = filteredFavoriteTutors;
    notifyListeners();
  }

  searchTutors({String? keyword, Map<String, dynamic>? filters}) async {
    var data =
        await tutorService.getTutors(keyword: keyword ?? "", filters: filters);
    var favoriteData = await tutorService.getUserFavoriteTutors();
    for (var tutor in data) {
      // if (favoriteData['${tutor.id}']['is_favorite'] == 1) {
      //   addFavoriteTutor(tutor);
      // }
      tutor.isFavorite = favoriteData['${tutor.id}'] == null
          ? false
          : favoriteData['${tutor.id}']['is_favorite'] == 1
              ? true
              : false;
    }
    _tutors = data;

    notifyListeners();
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
