import 'package:tutor_raya_mobile/models/category.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class CategoryService {
  AuthProvider authProvider;
  late String token;

  CategoryService(this.authProvider) {
    token = authProvider.token;
  }

  Future<List<Category>> getCategories() async {
    final response = await http.get(
      Uri.parse(API_ROOT + '/categories'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = data['data'];
      List<Category> categories =
          data.map<Category>((item) => Category.fromJson(item)).toList();
      return categories;
    } else {
      return <Category>[];
    }
  }
}
