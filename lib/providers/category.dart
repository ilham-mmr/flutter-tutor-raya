import 'package:flutter/material.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/services/category_api.dart';

class CategoryProvider with ChangeNotifier {
  // AuthProvier
  AuthProvider authProvider;
  //  ApiService apiService;
  late CategoryService categoryService;

  CategoryProvider(this.authProvider) {
    categoryService = CategoryService(authProvider);
  }

  getCategories() async {
    var data = await categoryService.getCategories();
    return data;
    // var url = Uri.parse('https://luxfortis.studio/app/subjects/subjects.php');
    // var response = await http.get(url);
    // if (response.statusCode == 200) {
    //   var data = jsonDecode(response.body);
    //   data = data['subjects'];

    //   List<Subject> subjects =
    //       data.map<Subject>((item) => Subject.fromJson(item)).toList();
    //   // subjects.forEach((e) => print(e.image));
    //   return subjects;
    // } else {
    //   return <Subject>[];
    // }
  }
}
