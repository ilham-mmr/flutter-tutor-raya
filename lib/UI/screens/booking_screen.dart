import 'package:flutter/material.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Image.asset('assets/images/confetti.png'),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Yeay',
                  style: kTitleBoldTextStyle,
                ),
                const Text(
                  'You have just booked one lesson',
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Ok",
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        kOrangeBackgroundColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
