import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<AuthProvider>(context, listen: false);
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
                          child: SizedBox(
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
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.shoppingBasket),
                        label: Text("Book a lesson"),
                        style: ElevatedButton.styleFrom(
                          primary: kOrangeBackgroundColor,
                          textStyle: TextStyle(fontSize: 15),
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
