import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/icon.png',
                              height: 100,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Welcome Back, Buddy!',
                              style: kTitleBoldTextStyle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SvgPicture.asset(
                        'assets/images/illustration/undraw_quiz_re_aol4.svg',
                        height: 150,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Gain knowledge and be inspired',
                        style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                      ),
                    ],
                  ),
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
                      onPressed: signIn,
                      label: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Log In with Google',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      icon: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FaIcon(
                          FontAwesomeIcons.google,
                        ),
                      ),
                      style: kTorqueiseElevatedButtonSytle,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: ElevatedButton.icon(
                  //     onPressed: () {
                  //       Navigator.of(context)
                  //           .pushReplacementNamed('/main-screen');
                  //     },
                  //     label: const Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Text(
                  //         'Log In with Facebook',
                  //         style: TextStyle(fontSize: 20),
                  //       ),
                  //     ),
                  //     icon: const Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: FaIcon(
                  //         FontAwesomeIcons.facebook,
                  //       ),
                  //     ),
                  //     style: kTorqueiseElevatedButtonSytle,
                  //   ),
                  // ),
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
      Navigator.of(context).popUntil(ModalRoute.withName("/"));
    }
  }
}
