import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/UI/widgets/favorite_card.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/providers/tutor.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';

class FavoritedScreen extends StatefulWidget {
  const FavoritedScreen({Key? key}) : super(key: key);

  @override
  State<FavoritedScreen> createState() => _FavoritedScreenState();
}

class _FavoritedScreenState extends State<FavoritedScreen> {
  // TutorProvider? tutor;
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   tutor = Provider.of<TutorProvider>(context, listen: false);
    // });
    // if (tutor != null) {
    //   tutor!.getFavoriteTutors();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var currentUser = Provider.of<AuthProvider>(context, listen: false).user;
    Provider.of<TutorProvider>(context, listen: false).getFavoriteTutors();

    return Scaffold(
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
                        backgroundImage: currentUser?.picture != null
                            ? NetworkImage(
                                "$API_STORAGE${currentUser?.picture!}")
                            : const AssetImage(
                                    "assets/images/blank-profile.png")
                                as ImageProvider,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Favorited',
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
                      child: Consumer<TutorProvider>(
                        builder: (context, tutorsList, child) {
                          List<Tutor> tutors = tutorsList.favoriteTutors;
                          // return FutureBuilder(
                          //   future: tutorsList.getFavoriteTutors(),
                          //   builder: (BuildContext context,
                          //       AsyncSnapshot<dynamic> snapshot) {

                          //   },

                          // );
                          print(tutors);
                          return ListView.builder(
                            itemCount: tutors.length,
                            itemBuilder: (context, index) {
                              return ChangeNotifierProvider.value(
                                  // ignore: prefer_const_constructors
                                  value: tutors[index],
                                  child: const FavoritedCard());
                            },
                          );
                        },
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
