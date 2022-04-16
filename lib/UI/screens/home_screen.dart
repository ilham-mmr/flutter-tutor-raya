// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutor_raya_mobile/UI/screens/main_screen.dart';
import 'package:tutor_raya_mobile/UI/screens/testing_screen.dart';
import 'package:tutor_raya_mobile/UI/widgets/category_card.dart';
import 'package:tutor_raya_mobile/UI/widgets/tutor_card.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // backgroundColor: kBasicBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 300,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: kTorqueiseBackgroundColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Hello, Ilham',
                              style: kTitleBoldTextStyle,
                            ),
                          ),
                          Expanded(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://i.pinimg.com/236x/c9/9a/5e/c99a5e7846dd69c9de812983942e346f.jpg"),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: 'Search Tutor here',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Categories',
                      textAlign: TextAlign.start,
                      style: kTitleBoldTextStyle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          CategoryCard(
                              name: 'Technology',
                              onTap: () {
                                print('hi');
                              }),
                          CategoryCard(name: 'Maths', onTap: () {}),
                          CategoryCard(name: 'Technology', onTap: () {}),
                          CategoryCard(name: 'Technology', onTap: () {}),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tutors',
                          textAlign: TextAlign.start,
                          style: kTitleBoldTextStyle.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('hi');
                          },
                          child: Text(
                            'See All',
                            textAlign: TextAlign.start,
                            style: kTitleBoldTextStyle.copyWith(
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 220,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          TutorCard(),
                          TutorCard(),
                          TutorCard(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 150);
    var firstStart = Offset(size.width / 10, size.height);
    var firstEnd = Offset(size.width, size.height);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
