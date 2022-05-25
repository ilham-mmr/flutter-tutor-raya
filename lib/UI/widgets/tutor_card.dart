import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tutor_raya_mobile/UI/screens/detail_screen.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';

class TutorCard extends StatefulWidget {
  const TutorCard({
    Key? key,
    required this.tutor,
  }) : super(key: key);

  final Tutor tutor;

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  bool isFavorited = false;
  @override
  Widget build(BuildContext context) {
    var tutor = widget.tutor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 200,
            width: 200,
            child: GestureDetector(
              onTap: () {
                pushNewScreen(
                  context,
                  screen: DetailScreen(tutorId: tutor.id!),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image(
                          image: tutor.picture != null
                              ? NetworkImage("$API_STORAGE${tutor.picture!}")
                              : const AssetImage(
                                      "assets/images/blank-profile.png")
                                  as ImageProvider,
                          height: 100,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 70,
                        right:
                            15, //give the values according to your requirement
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorited = !isFavorited;
                            });
                          },
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: Icon(
                              isFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(tutor.name!)),
                        if (tutor.minPrice != null &&
                            tutor.maxPrice != null) ...[
                          Flexible(
                              child: Text(
                                  'Rp${tutor.minPrice}-${tutor.maxPrice}/hr')),
                        ]
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      ...?tutor.categories?.map((e) => Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(e),
                          ))
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
