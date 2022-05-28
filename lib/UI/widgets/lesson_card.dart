import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_raya_mobile/models/lesson.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    required this.lesson,
    Key? key,
  }) : super(key: key);

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 12),
                child: Text(
                  lesson.tutor!,
                  style: kTitleBoldTextStyle,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('ID:${lesson.id}'),
                        CircleAvatar(
                          radius: 36,
                          backgroundImage: lesson.picture != null
                              ? NetworkImage(
                                  "$API_STORAGE${lesson.picture!}",
                                )
                              : const AssetImage(
                                      "assets/images/blank-profile.png")
                                  as ImageProvider,
                          backgroundColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          lesson.title!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(lesson.getFormattedTime()),
                        Text(lesson.getFormmatedDate()),
                        Text('Status: ${lesson.status}'),
                        Text('RP${lesson.totalPrice}'),
                        if (lesson.status == "ACCEPTED") ...[
                          if (lesson.phoneNumber != null) ...[
                            IconButton(
                                onPressed: () async {
                                  var url =
                                      Uri.parse('tel:${lesson.phoneNumber}');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url,
                                        mode: LaunchMode.externalApplication);
                                  }
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.phoneAlt,
                                  color: kOrangeBackgroundColor,
                                )),
                          ],
                          ElevatedButton.icon(
                            onPressed: lesson.meetingLink != null
                                ? () async {
                                    var url = Uri.parse(lesson.meetingLink!);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url,
                                          mode: LaunchMode.externalApplication);
                                    }
                                  }
                                : null,
                            icon: const FaIcon(FontAwesomeIcons.link),
                            label: const Text("Meeting Link"),
                            style: ElevatedButton.styleFrom(
                              primary: kOrangeBackgroundColor,
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ]
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
