import 'package:flutter/material.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({required this.name, required this.onTap, Key? key})
      : super(key: key);

  final String name;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 6),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 30,
          width: 171,
          decoration: BoxDecoration(
              color: kOrangeBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: kTitleWhiteTextStyle,
                  ),
                ),
                CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: kBlackColor,
                    ))
              ],
            ),
          )),
        ),
      ),
    );
  }
}
