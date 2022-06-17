import 'package:flutter/material.dart';
import 'package:tutor_raya_mobile/models/category.dart';
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

  List<Category> _categoryList = [];

  List<Category> get categoryList {
    return _categoryList;
  }

  void emptyCategoryList() {
    _categoryList = [];
    notifyListeners();
  }

  getCategoryList() async {
    var data = await getCategories();
    _categoryList = data;
    notifyListeners();
  }

  getCategories() async {
    var data = await categoryService.getCategories();
    return data;
  }
}
