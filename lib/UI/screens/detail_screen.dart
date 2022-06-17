import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:tutor_raya_mobile/UI/screens/booking_screen.dart';
import 'package:tutor_raya_mobile/UI/widgets/category_card.dart';
import 'package:tutor_raya_mobile/models/category.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/models/tutoring.dart';
import 'package:tutor_raya_mobile/providers/tutor.dart';
import 'package:tutor_raya_mobile/providers/tutoring.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({required this.tutorId, Key? key}) : super(key: key);

  final int tutorId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Consumer<TutorProvider>(
          builder: (context, tutor, _) => FutureBuilder(
            future: tutor.getTutorDetail(widget.tutorId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Sorry the tutor can't be found",
                      style: kTitleBoldTextStyle),
                );
              }
              if (snapshot.hasData) {
                var retrievedTutor = snapshot.data as Tutor;
                return _buildDetailSection(
                    height, width, retrievedTutor, context);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(
      double height, double width, Tutor? tutor, BuildContext context) {
    if (tutor == null) {
      return Center(
        child:
            Text("Sorry the tutor can't be found", style: kTitleBoldTextStyle),
      );
    }
    return Stack(
      children: [
        Image(
          image: tutor.picture != null
              ? NetworkImage("$API_STORAGE${tutor.picture!}")
              : const AssetImage("assets/images/blank-profile.png")
                  as ImageProvider,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        ListView(
          children: [
            SizedBox(
              height: height * 0.5,
            ),
            Container(
              width: width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutor.name!,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    index == 0 ? _buildProfile(tutor) : _buildTutorings(tutor)
                  ],
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: kBlackColor),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  SizedBox _buildProfile(Tutor? tutor) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: kTitleBoldTextStyle.copyWith(fontSize: 20),
          ),
          SizedBox(
            height: 100,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: tutor!.categories!
                    .map<CategoryCard>((e) => CategoryCard(
                        category: Category(
                          name: e,
                        ),
                        tappable: false))
                    .toList()),
          ),
          Text(
            'Teaches',
            style: kTitleBoldTextStyle.copyWith(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: tutor.subjects == null
                  ? []
                  : tutor.subjects!
                      .map<Widget>(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(e.toString()),
                        ),
                      )
                      .toList(),
            ),
          ),
          Text(
            'About Me',
            style: kTitleBoldTextStyle.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(tutor.about ?? "No description"),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Education',
            style: kTitleBoldTextStyle.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            tutor.education ?? "No description",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            tutor.degree ?? "No description",
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: kOrangeBackgroundColor, // background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                onPressed: () {
                  setState(() {
                    index = 1;
                  });
                },
                child: Text(
                  'View Schedule',
                  style: kTitleWhiteTextStyle,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  _buildTutorings(Tutor? tutor) {
    if (tutor?.tutorings == null) {
      return Center(
        child: Text("Sorry there are no tutoring sessions available",
            style: kTitleBoldTextStyle),
      );
    }
    var tutorings = tutor?.tutorings ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Avalability',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kBlackColor,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
              child: Text(
                "Profile",
                style: TextStyle(color: kOrangeBackgroundColor),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 6),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: tutorings
                    .map<Widget>(
                      (tutoring) => TutoringExpansionTile(
                          context: context, tutoring: tutoring),
                    )
                    .toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TutoringExpansionTile extends StatelessWidget {
  const TutoringExpansionTile({
    Key? key,
    required this.context,
    required this.tutoring,
  }) : super(key: key);

  final BuildContext context;
  final Tutoring tutoring;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
          color: kOrangeBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.white, // here for close state
          colorScheme: const ColorScheme.light(
            primary: Colors.white,
          ), // here for open state in replacement of deprecated accentColor
          dividerColor: Colors.transparent, // if you want to remove the border
        ),
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tutoring.title!,
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                tutoring.getFormmatedDatetime(),
                style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          children: <Widget>[
            ExpansionTile(
              backgroundColor: kOrangeBackgroundColor,
              collapsedBackgroundColor: kOrangeBackgroundColor,
              textColor: Colors.black,
              collapsedTextColor: Colors.black,
              title: const Text(
                "Description",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    tutoring.description!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price : RP${tutoring.totalPrice}",
                    style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, // background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                    onPressed: () async {
                      context.loaderOverlay.show();
                      bool isBooked = await Provider.of<TutoringProvider>(
                              context,
                              listen: false)
                          .bookTutoring(tutoring.id!);

                      if (isBooked) {
                        pushNewScreen(
                          context,
                          screen: const BookingScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      } else {
                        Toast.show("You have booked this session!",
                            duration: Toast.lengthLong, gravity: Toast.bottom);
                      }

                      context.loaderOverlay.hide();
                    },
                    child: Text(
                      'Book Now',
                      style: TextStyle(color: kOrangeBackgroundColor),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
