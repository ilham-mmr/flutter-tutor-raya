import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:tutor_raya_mobile/UI/screens/main_screen.dart';
import 'package:tutor_raya_mobile/UI/screens/splash_screen.dart';
import 'package:tutor_raya_mobile/UI/widgets/loading.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';
import 'package:tutor_raya_mobile/providers/category.dart';
import 'package:tutor_raya_mobile/providers/tutor.dart';
import 'package:tutor_raya_mobile/providers/tutoring.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: GlobalLoaderOverlay(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tutor Raya',
          initialRoute: '/',
          theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(),
            backgroundColor: kBasicBackgroundColor,
          ),
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
            return const SplashScreen();
          case Status.Authenticated:
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => CategoryProvider(authProvider),
                ),
                ChangeNotifierProvider(
                  create: (_) => TutorProvider(authProvider),
                ),
                ChangeNotifierProvider(
                  create: (_) => TutoringProvider(authProvider),
                ),
                ChangeNotifierProvider.value(
                  value: Tutor(),
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
