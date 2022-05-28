// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/UI/widgets/category_card.dart';
import 'package:tutor_raya_mobile/UI/widgets/tutor_card.dart';
import 'package:tutor_raya_mobile/models/category.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/providers/category.dart';
import 'package:tutor_raya_mobile/providers/tutor.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    return Scaffold(
      // backgroundColor: kBasicBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.loaderOverlay.show();
            await Future.delayed(Duration(seconds: 3));
            context.loaderOverlay.hide();

            setState(() {});
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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
                                'Hello, ${user?.name}',
                                style: kTitleBoldTextStyle,
                              ),
                            ),
                            Expanded(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: user?.picture != null
                                    ? NetworkImage(
                                        "$API_STORAGE${user?.picture!}")
                                    : AssetImage(
                                            "assets/images/blank-profile.png")
                                        as ImageProvider,

                                // backgroundImage: NetworkImage(user!.picture!),
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
                        child: Consumer<CategoryProvider>(
                          builder: (context, category, _) => FutureBuilder(
                              future: category.getCategories(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data as List<Category>;
                                  if (data.isNotEmpty) {
                                    return ListView(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(8),
                                      children: data
                                          .map<Widget>((category) =>
                                              CategoryCard(category: category))
                                          .toList(),
                                    );
                                  }
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
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
                              final user = Provider.of<TutorProvider>(context,
                                      listen: false)
                                  .getTutors(5);
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
                        child: Consumer<TutorProvider>(
                          builder: (context, tutor, _) => FutureBuilder(
                              future: tutor.getTutors(5),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data as List<Tutor>;
                                  if (data.isNotEmpty) {
                                    return ListView(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(8),
                                      children: data
                                          .map<Widget>((tutor) =>
                                              TutorCard(tutor: tutor))
                                          .toList(),
                                    );
                                  }
                                  return Center(
                                    child: Text(
                                      'No Available Tutors At the moment',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
