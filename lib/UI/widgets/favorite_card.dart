import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';

class FavoritedCard extends StatelessWidget {
  const FavoritedCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 19,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/236x/c9/9a/5e/c99a5e7846dd69c9de812983942e346f.jpg"),
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      'David',
                      style: kTitleBoldTextStyle,
                    ),
                    Text('Technology Science'),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.shoppingBasket),
                      label: Text("Book a lesson"),
                      style: ElevatedButton.styleFrom(
                        primary: kOrangeBackgroundColor,
                        textStyle: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
