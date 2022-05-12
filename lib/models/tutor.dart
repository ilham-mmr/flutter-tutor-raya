import 'package:tutor_raya_mobile/models/tutoring.dart';

class Tutor {
  int? id;
  String? name, picture, about, education, degree;
  List<dynamic>? categories;
  List<dynamic>? subjects;
  num? minPrice;
  num? maxPrice;

  Tutor({
    this.id,
    this.name,
    this.picture,
    this.categories,
    this.minPrice,
    this.maxPrice,
    this.about,
    this.degree,
    this.education,
    this.subjects,
  });

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
      subjects: json["subjects"]);

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
        'subjects': subjects
      };
}
