import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/models/user.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _aboutController = TextEditingController();
  late final TextEditingController _educationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _aboutController.dispose();
    _educationController.dispose();
  }

  bool isEditing = false;
  bool submit = false;

  String about = "";
  String education = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;

    double height = MediaQuery.of(context).size.height;
    print('hi');
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Profile',
                                style: kTitleBoldTextStyle,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isEditing) {
                                        print(about);
                                        print(_educationController.text);
                                        updateUserInfo(context);
                                        // clear text after update
                                        // _aboutController.clear();
                                        // _educationController.clear();
                                      }
                                      isEditing = !isEditing;
                                    });
                                  },
                                  icon: isEditing
                                      ? const FaIcon(FontAwesomeIcons.solidSave)
                                      : const FaIcon(
                                          FontAwesomeIcons.pencilAlt))
                            ]),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: user?.picture != null
                                    ? NetworkImage(
                                        "$API_STORAGE${user?.picture!}")
                                    : const AssetImage(
                                            "assets/images/blank-profile.png")
                                        as ImageProvider,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Flexible(
                              child: Text(
                                user!.name!.toUpperCase(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Email',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              user.email!,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'About Me',
                              style: TextStyle(fontSize: 18),
                            ),
                            isEditing
                                ? TextField(
                                    controller: TextEditingController()
                                      ..text = user.about ?? '',
                                    onChanged: (text) => {about = text},
                                  )
                                : Text(
                                    user.about ?? "-",
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Education',
                              style: TextStyle(fontSize: 18),
                            ),
                            isEditing
                                ? TextField(
                                    controller: TextEditingController()
                                      ..text = user.education ?? '',
                                    onChanged: (text) => {education = text},
                                  )
                                : Text(
                                    user.education ?? "-",
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                showLogoutConfirmationDialog(context);
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
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

  updateUserInfo(BuildContext context) async {
    submit = true;
    context.loaderOverlay.show();
    await Provider.of<AuthProvider>(context, listen: false)
        .updateAbout(about, education);
    context.loaderOverlay.hide();

    print(_aboutController.text);
    print(_educationController.text);
  }

  showLogoutConfirmationDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');

        logOut(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to log out?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future logOut(BuildContext context) async {
    context.loaderOverlay.show();
    await Provider.of<AuthProvider>(context, listen: false).logOut();
    context.loaderOverlay.hide();
  }
}
