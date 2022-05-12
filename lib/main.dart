import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:tutor_raya_mobile/UI/screens/main_screen.dart';
import 'package:tutor_raya_mobile/UI/screens/splash_screen.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/providers/category.dart';
import 'package:tutor_raya_mobile/providers/tutor.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: GlobalLoaderOverlay(
        child: MaterialApp(
          title: 'Tutor Raya',
          initialRoute: '/',
          theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(),
            backgroundColor: kBasicBackgroundColor,
          ),
          // onGenerateRoute: RouteGenerator.generateRoute,
          routes: {
            '/': (context) => const RouterAuth(),
          },
        ),
      ),
    ),
  );
}

class RouterAuth extends StatelessWidget {
  const RouterAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    final authProvider = Provider.of<AuthProvider>(context);

    return Consumer<AuthProvider>(
      builder: (context, user, child) {
        switch (user.status) {
          case Status.Uninitialized:
            return const Loading();
          case Status.Unauthenticated:
            return const LoginScreen();
          case Status.Authenticated:
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => CategoryProvider(authProvider),
                ),
                ChangeNotifierProvider(
                  create: (_) => TutorProvider(authProvider),
                ),
              ],
              child: MainScreen(),
            );
          case Status.Authenticating:
            return const Loading();

          default:
            return const Text('default');
        }
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  initAuthProvider(context) async {
    Provider.of<AuthProvider>(context, listen: false).initAuthProvider();
  }

  @override
  Widget build(BuildContext context) {
    initAuthProvider(context);

    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
