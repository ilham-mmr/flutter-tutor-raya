import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/UI/widgets/favorite_card.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final user = Provider.of<AuthProvider>(context, listen: false).user;

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
                    Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: user?.picture != null
                              ? NetworkImage("$API_STORAGE${user?.picture!}")
                              : const AssetImage(
                                      "assets/images/blank-profile.png")
                                  as ImageProvider,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Lessons',
                        style: kTitleBoldTextStyle,
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
                      child: ListView(
                        children: [
                          FavoritedCard(),
                          FavoritedCard(),
                          FavoritedCard(),
                          FavoritedCard(),
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
