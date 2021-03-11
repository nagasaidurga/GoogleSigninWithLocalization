
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:secure_signin_custom_theme/localization/app_localizations.dart';
import 'package:secure_signin_custom_theme/utils/secure_storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    print("init state");
      SchedulerBinding.instance.addPostFrameCallback((_) async {
      var user = await getUserData();
      if (user ==true) {
        print("sai");
        handleGoogleSignin(_context);
      }});

  }

  Future<bool> getUserData() async {
    var user = await SecureStorage().readSecureData('user_session');
    if (user != null)
      return true;
    else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                AppLocalizations.of(context).translate('login'),
                style: Theme.of(context).textTheme.headline,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('username'),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('password'),
                ),
                obscureText: true,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                AppLocalizations.of(context).translate('forgot_pwd'),
                style: Theme.of(context).textTheme.display2,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Theme.of(context).buttonColor,
                        Theme.of(context).buttonColor
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    AppLocalizations.of(context).translate('login'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
                child: Text(
              "Or",
              style: Theme.of(context).textTheme.display2,
            )),
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  handleGoogleSignin(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 60.0,
                  width: size.width * 0.9,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Theme.of(context).buttonColor,
                        Theme.of(context).buttonColor
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    AppLocalizations.of(context).translate('google_login'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleGoogleSignin(BuildContext context) {
    //with google and firebase
    /* Navigator.of(context).pushNamed(
      '/authprocess',
      arguments: 'sai',
    );*/
    //only google signin
    Navigator.of(context).pushNamed('/googleprocess');
  }
}
