import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/providers/auth.dart';

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
