import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_signin_custom_theme/provider/google_sign_in_provider.dart';
import 'package:secure_signin_custom_theme/ui/widget/background_painter.dart';
import 'package:secure_signin_custom_theme/ui/widget/logged_in_widget.dart';
import 'package:secure_signin_custom_theme/ui/widget/sign_up_widget.dart';

class GoogleAuthProcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<GoogleSignInProvider>(context);
          print("issignin"+provider.isSigningIn.toString());
          if (provider.isSigningIn) {
            return buildLoading();
          } else if (snapshot.hasData) {
            print("data"+snapshot.data.toString());
            return LoggedInWidget();
          } else {
            return SignUpWidget();
          }
        },
      ),
    ),
  );

  Widget buildLoading() => Stack(
    fit: StackFit.expand,
    children: [
      CustomPaint(painter: BackgroundPainter()),
      Center(child: CircularProgressIndicator()),
    ],
  );
}