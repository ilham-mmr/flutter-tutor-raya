import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_raya_mobile/UI/widgets/favorite_card.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: kBasicBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: height * 0.2,
                  child: Container(
                    color: kTorqueiseBackgroundColor,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Profile',
                          style: kTitleBoldTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: height,
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    "https://i.pinimg.com/236x/c9/9a/5e/c99a5e7846dd69c9de812983942e346f.jpg"),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Text(
                              'Ilham',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Email',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'ilham.mmr@gmail.com',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'About Me',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'asjkdflasjfklasd',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {},
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
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
