import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/UI/screens/login_screen.dart';
import 'package:tutor_raya_mobile/UI/screens/main_screen.dart';
import 'package:tutor_raya_mobile/UI/screens/testing_screen.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/services/google_signin_api.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SvgPicture.asset(
                    'assets/images/illustration/undraw_searching_re_3ra9.svg',
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: const LoginScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.slideUp,
                        );

                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             const LoginScreen()));
                      },
                      label: const Text(
                        'Explore Now',
                        style: TextStyle(fontSize: 20),
                      ),
                      icon: const FaIcon(
                        FontAwesomeIcons.arrowCircleRight,
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

  Future signIn() async {
    bool isLoggedIn =
        await Provider.of<AuthProvider>(context, listen: false).login();
    String message = "Login Failed";
    if (isLoggedIn) {
      message = "Login Successful";
    }
    print(message);
  }
}
