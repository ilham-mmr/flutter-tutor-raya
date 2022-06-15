import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _aboutController = TextEditingController();
  late final TextEditingController _educationController =
      TextEditingController();
  late final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _aboutController.dispose();
    _educationController.dispose();
    _phoneController.dispose();
  }

  bool isEditing = false;
  bool submit = false;

  // String about = "";
  // String education = "";
  // String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: true).user;
    _aboutController.text = user?.about ?? "";
    _educationController.text = user?.education ?? "";
    _phoneController.text = user?.phoneNumber ?? "";

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: kBasicBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
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
                child: SingleChildScrollView(
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
                              ]),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: height * 0.9,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: user?.picture != null
                                          ? NetworkImage("${user?.picture!}")
                                          : const AssetImage(
                                                  "assets/images/blank-profile.png")
                                              as ImageProvider,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                user!.name!.toUpperCase(),
                                style: const TextStyle(fontSize: 18),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Email',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),

                              Text(
                                user.email!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.grey),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isEditing) {
                                        // print(about);
                                        // print(phoneNumber);
                                        // print(education);
                                        print(_aboutController.text);
                                        print(_educationController.text);
                                        print(_phoneController.text);
                                        updateUserInfo(context);
                                      }
                                      isEditing = !isEditing;
                                    });
                                  },
                                  icon: isEditing
                                      ? FaIcon(
                                          FontAwesomeIcons.solidSave,
                                          color: kTorqueiseBackgroundColor,
                                        )
                                      : FaIcon(
                                          FontAwesomeIcons.pencilAlt,
                                          color: kTorqueiseBackgroundColor,
                                        )),

                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Text(
                                  'About Me',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),

                              isEditing
                                  ? TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: _aboutController,
                                      autofocus: false,
                                      cursorColor: kTorqueiseBackgroundColor,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kBasicBackgroundColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: kTorqueiseBackgroundColor,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12.0))),
                                        hintText: 'about',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                      ),
                                    )
                                  : Text(
                                      user.about ?? "-",
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Education',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              isEditing
                                  ? TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: _educationController,
                                      autofocus: false,
                                      cursorColor: kTorqueiseBackgroundColor,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kBasicBackgroundColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: kTorqueiseBackgroundColor,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12.0))),
                                        hintText: 'education',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                      ),
                                    )
                                  : Text(
                                      user.education ?? "-",
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Phone Number',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              isEditing
                                  ? TextFormField(
                                      // keyboardType: TextInputType.number,
                                      controller: _phoneController,
                                      autofocus: false,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      cursorColor: kTorqueiseBackgroundColor,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kBasicBackgroundColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: kTorqueiseBackgroundColor,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12.0))),
                                        hintText: 'e.g. +601234234',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                      ))
                                  : Text(
                                      user.phoneNumber ?? "-",
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),

                              // ),
                              // isEditing
                              //     ? TextField(
                              //         controller: _aboutController,
                              //         onChanged: (text) => {about = text},
                              //       )
                              //     : Text(
                              //         user.about ?? "-",
                              //         style: const TextStyle(
                              //             fontSize: 18, color: Colors.grey),
                              //       ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // const Text(
                              //   'Education',
                              //   style: TextStyle(fontSize: 18),
                              // ),
                              // isEditing
                              //     ? TextField(
                              //         controller: _educationController,
                              //         onChanged: (text) => {education = text},
                              //       )
                              //     : Text(
                              //         user.education ?? "-",
                              //         style: const TextStyle(
                              //             fontSize: 18, color: Colors.grey),
                              //       ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // const Text(
                              //   'Phone Number',
                              //   style: TextStyle(fontSize: 18),
                              // ),
                              // isEditing
                              //     ? TextField(
                              //         controller: _phoneController,
                              //         onChanged: (val) {
                              //           print(val);
                              //         },
                              //         inputFormatters: [
                              //           FilteringTextInputFormatter.digitsOnly
                              //         ],
                              //         keyboardType: TextInputType.number,
                              //       )
                              //     : Text(
                              //         user.phoneNumber ?? "-",
                              //         style: const TextStyle(
                              //             fontSize: 18, color: Colors.grey),
                              //       ),
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
    await Provider.of<AuthProvider>(context, listen: false).updateAbout(
        _aboutController.text,
        _educationController.text,
        _phoneController.text);
    context.loaderOverlay.hide();
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
