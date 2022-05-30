import 'package:flutter/cupertino.dart';
import 'package:tutor_raya_mobile/models/tutoring.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class Tutor with ChangeNotifier {
  int? id;
  String? name, picture, about, education, degree;
  List<dynamic>? categories;
  List<dynamic>? subjects;
  num? minPrice;
  num? maxPrice;
  List<Tutoring>? tutorings;
  bool isFavorite;

  Tutor(
      {this.id,
      this.name,
      this.picture,
      this.categories,
      this.minPrice,
      this.maxPrice,
      this.about,
      this.degree,
      this.education,
      this.subjects,
      this.tutorings,
      this.isFavorite = false});

  factory Tutor.fromJson(Map<String, dynamic> json) => Tutor(
        id: json['id'],
        name: json['name'],
        picture: json['picture'],
        categories: json['categories'],
        minPrice: json['minimum_price'],
        maxPrice: json['maximum_price'],
        about: json["about"],
        degree: json["degree"],
        education: json["education"],
        subjects: json["subjects"],
        // tutorings: json["tutorings"]
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'picture': picture,
        'categories': categories,
        'minimum_price': minPrice,
        'maximum_price': maxPrice,
        'about': about,
        'degree': degree,
        'education': education,
        'subjects': subjects,
        // 'tutorings': tutorings
      };

  _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String tutorId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    var url = Uri.parse(API_ROOT + "/tutor-favorites");

    // send url

    try {
      final response = await http.put(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Accept': 'application/json'
      }, body: {
        'tutor_id': tutorId,
        'is_favorite': isFavorite ? '1' : '0'
      });

      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
