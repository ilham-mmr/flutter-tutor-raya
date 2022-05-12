import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/UI/screens/booking_screen.dart';
import 'package:tutor_raya_mobile/UI/widgets/category_card.dart';
import 'package:tutor_raya_mobile/models/category.dart';
import 'package:tutor_raya_mobile/providers/tutor.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';

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
    print(widget.tutorId);
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
              if (snapshot.hasData) {
                // print(snapshot.data);
                return _buildDetailSection(height, width, context);
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

  Stack _buildDetailSection(double height, double width, BuildContext context) {
    return Stack(
      children: [
        Image.network(
          "https://image.shutterstock.com/image-photo/close-portrait-smiling-handsome-man-260nw-1011569245.jpg",
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
                      'Kuretakeso Hott',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    index == 0 ? _buildProfile() : _buildTutorings()
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
            InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  SizedBox _buildProfile() {
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
              children: [
                CategoryCard(
                  category: Category(id: 1, name: "Science"),
                  tappable: false,
                ),
                CategoryCard(
                  category: Category(id: 1, name: "Social Science"),
                  tappable: false,
                ),
                CategoryCard(
                  category: Category(id: 1, name: "Language"),
                  tappable: false,
                ),
              ],
            ),
          ),
          Text(
            'Teaches',
            style: kTitleBoldTextStyle.copyWith(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text('Physics'),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text('maths'),
                ),
              ],
            ),
          ),
          Text(
            'About Me',
            style: kTitleBoldTextStyle.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'ed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, qu',
          ),
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
          const Text(
            'Universiti Utara Malaysia',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'Bachelor of Science with Honors Information Technology (Software Engineering)',
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

  _buildTutorings() {
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
                children: [
                  TutoringExpansionTile(context: context),
                  TutoringExpansionTile(context: context),
                ],
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
  }) : super(key: key);

  final BuildContext context;

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
          // backgroundColor: kOrangeBackgroundColor,
          // collapsedBackgroundColor: kOrangeBackgroundColor,
          // textColor: Colors.black,
          // collapsedTextColor: Colors.black,
          // collapsedIconColor: Colors.black,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Learn Maths With Fun | Maths",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Friday, 24rd June 2021 10:00 - 11:00",
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
                const ListTile(
                  title: const Text(
                    " ed ut perspiciatis unde omnis iste natus error sit vo qu",
                    style: TextStyle(
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
                    "Total Price : RM120",
                    style: TextStyle(
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
                    onPressed: () {
                      pushNewScreen(
                        context,
                        screen: BookingScreen(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
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