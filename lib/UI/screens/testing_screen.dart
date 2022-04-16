import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tutor_raya_mobile/UI/screens/splash_screen.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';

class TestingScreen extends ConsumerWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('hi')),
      // backgroundColor: kBasicBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/images/circles.png'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'Find Your Best Tutors Here',
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Tutoring is a fulfilling experience',
                      style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                    ),
                  ],
                )
              ]),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      label: const Text(
                        'back',
                        style: TextStyle(fontSize: 20),
                      ),
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                      ),
                      style: kTorqueiseElevatedButtonSytle,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
