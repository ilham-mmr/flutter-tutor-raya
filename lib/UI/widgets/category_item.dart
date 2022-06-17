import 'package:flutter/material.dart';
import 'package:tutor_raya_mobile/models/category.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem(
      {Key? key,
      required this.category,
      required this.onSelected,
      this.isSelected})
      : super(key: key);

  final Category category;
  final ValueChanged<bool> onSelected;
  final bool? isSelected;
  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isSelected ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onSelected(_isSelected);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Chip(
          label: Text(
            widget.category.name!,
            style: TextStyle(color: _isSelected ? Colors.white : Colors.black),
          ),
          backgroundColor:
              _isSelected ? kOrangeBackgroundColor : Colors.grey[300],
        ),
      ),
    );
  }
}
