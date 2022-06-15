import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/UI/widgets/lesson_card.dart';
import 'package:tutor_raya_mobile/models/lesson.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/providers/tutoring.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final user = Provider.of<AuthProvider>(context, listen: false).user;

    return Scaffold(
      // backgroundColor: kBasicBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.loaderOverlay.show();
            await Future.delayed(Duration(seconds: 3));
            context.loaderOverlay.hide();

            setState(() {});
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                                ? NetworkImage("${user?.picture!}")
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
                        height: height * 0.7,
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
                        child: Consumer<TutoringProvider>(
                          builder: (context, category, _) => FutureBuilder(
                              future: category.getBookedLessons(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data as List<Lesson>;
                                  if (data.isNotEmpty) {
                                    return ListView(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(8),
                                      children: data
                                          .map<Widget>((lesson) =>
                                              LessonCard(lesson: lesson))
                                          .toList(),
                                    );
                                  }
                                  return SvgPicture.asset(
                                    'assets/images/illustration/undraw_diary_re_4jpc.svg',
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
