import 'package:flutter/material.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/services/tutor_api.dart';
import 'package:collection/collection.dart';

class TutorProvider with ChangeNotifier {
  // AuthProvier
  AuthProvider authProvider;
  //  ApiService apiService;
  late TutorService tutorService;
  List<Tutor> _tutors = [];
  List<Tutor> _favoriteTutors = [];
  List<Tutor> get tutors {
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
    for (var tutor in data) {
      if (favoriteData != null) {
        tutor.isFavorite = favoriteData['${tutor.id}'] == null
            ? false
            : favoriteData['${tutor.id}']['is_favorite'] == 1
                ? true
                : false;
      }
    }
    return data;
  }

  getFavoriteTutors() async {
    var favoriteTutors =
        await tutorService.getUserFavoriteTutors(withDetails: true);

    List<Tutor> tutors =
        favoriteTutors.map<Tutor>((item) => Tutor.fromJson(item)).toList();

    _favoriteTutors = tutors;
    notifyListeners();
  }

  addFavoriteTutor(Tutor tutor) {
    var foundTutor =
        _favoriteTutors.firstWhereOrNull((element) => element.id == tutor.id);
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

  removeRemoteFavoriteTutor(String id) async {
    return await tutorService.removeRemoteFavoriteTutor(id);
  }

  getTutorsByCategory({String? keyword}) async {
    var data = await tutorService
        .getTutors(keyword: "", filters: {'category': keyword});
    var favoriteData = await tutorService.getUserFavoriteTutors();

    for (var tutor in data) {
      if (favoriteData != null) {
        tutor.isFavorite = favoriteData['${tutor.id}'] == null
            ? false
            : favoriteData['${tutor.id}']['is_favorite'] == 1
                ? true
                : false;
      }
    }
    return data;
  }

  searchTutors({String? keyword, Map<String, dynamic>? filters}) async {
    var data =
        await tutorService.getTutors(keyword: keyword ?? "", filters: filters);
    var favoriteData = await tutorService.getUserFavoriteTutors();
    for (var tutor in data) {
      if (favoriteData != null) {
        tutor.isFavorite = favoriteData['${tutor.id}'] == null
            ? false
            : favoriteData['${tutor.id}']['is_favorite'] == 1
                ? true
                : false;
      }
    }
    _tutors = data;

    notifyListeners();
  }

  getTutorDetail(int? id) async {
    var data = await tutorService.getTutorDetail(id);
    return data;
  }
}
