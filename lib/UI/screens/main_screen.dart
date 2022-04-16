import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tutor_raya_mobile/UI/screens/favorited_screen.dart';
import 'package:tutor_raya_mobile/UI/screens/home_screen.dart';
import 'package:tutor_raya_mobile/UI/screens/profile_screen.dart';
import 'package:tutor_raya_mobile/UI/screens/search_screen.dart';
import 'package:tutor_raya_mobile/UI/screens/splash_screen.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,

      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
      onWillPop: (_) async {
        return false;
      },
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      FavoritedScreen(),
      SearchScreen(),
      Container(
        child: Text('hi anj'),
      ),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const FaIcon(
          FontAwesomeIcons.home,
        ),
        activeColorPrimary: kBlackColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const FaIcon(
          FontAwesomeIcons.solidHeart,
        ),
        activeColorPrimary: kBlackColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: CircleAvatar(
          backgroundColor: kTorqueiseBackgroundColor,
          child: const FaIcon(
            FontAwesomeIcons.search,
          ),
        ),
        activeColorPrimary: kBlackColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const FaIcon(
          FontAwesomeIcons.book,
        ),
        activeColorPrimary: kBlackColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const FaIcon(
          FontAwesomeIcons.userAlt,
        ),
        activeColorPrimary: kBlackColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
