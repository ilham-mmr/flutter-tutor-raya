import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:tutor_raya_mobile/UI/screens/detail_screen.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/providers/tutor.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';

class FavoritedCard extends StatefulWidget {
  const FavoritedCard({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritedCard> createState() => _FavoritedCardState();
}

class _FavoritedCardState extends State<FavoritedCard> {
  @override
  Widget build(BuildContext context) {
    var tutorProvider = Provider.of<TutorProvider>(context, listen: false);
    var tutor = Provider.of<Tutor>(context, listen: false);
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async {
        bool isRemoved =
            await tutorProvider.removeRemoteFavoriteTutor(tutor.id.toString());
        if (isRemoved) {
          tutorProvider.removeFavoriteTutor(tutor);
          Toast.show("removed from favorited list",
              duration: Toast.lengthLong, gravity: Toast.bottom);
        }
      },
      child: Padding(
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
                          child: GestureDetector(
                            onTap: () {
                              Toast.show("Slide the card away to remove",
                                  duration: Toast.lengthLong,
                                  gravity: Toast.bottom);
                            },
                            child: const SizedBox(
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
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: tutor.picture != null
                            ? NetworkImage("$API_STORAGE${tutor.picture!}")
                            : const AssetImage(
                                    "assets/images/blank-profile.png")
                                as ImageProvider,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        tutor.name!,
                        style: kTitleBoldTextStyle,
                      ),
                      Row(
                        children: tutor.categories!
                            .map<Widget>((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e),
                                ))
                            .toList(),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          pushNewScreen(
                            context,
                            screen: DetailScreen(tutorId: tutor.id!),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        icon: const FaIcon(FontAwesomeIcons.shoppingBasket),
                        label: const Text("Book a lesson"),
                        style: ElevatedButton.styleFrom(
                          primary: kOrangeBackgroundColor,
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
