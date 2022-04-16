import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_raya_mobile/route/route_generator.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutor Raya',
      initialRoute: '/',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        backgroundColor: kBasicBackgroundColor,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
