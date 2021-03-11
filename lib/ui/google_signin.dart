import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:secure_signin_custom_theme/localization/app_localizations.dart';
import 'package:secure_signin_custom_theme/utils/secure_storage.dart';

class GoogleSigninProcess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoogleSigninState();
  }
}

class _GoogleSigninState extends State<GoogleSigninProcess> {
  bool _isLoggedIn = false;
  User user;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      var userSession = await getUserData();
      if (userSession == true) {
        await secureStorage.readSecureObject('user_object').then((temp) {
          setState(() {
            user = temp;
            _isLoggedIn = true;
            print("user value" + user.email);
          });
        });
      } else {
        _isLoggedIn = false;
      }
    });
  }

  _login() async {
    try {
      await _googleSignIn.signIn();
      secureStorage.writeSecureData(
          'user_session', _googleSignIn.currentUser.id);
      secureStorage.writeSecureObject('user_object', _googleSignIn.currentUser);
      await secureStorage.readSecureObject('user_object').then((temp) {
        setState(() {
          user = temp;
          _isLoggedIn = true;
          print("user value" + user.email);
        });
      });
      await _googleSignIn.currentUser.authentication.then((googleKey) {
        // access token => googleKey.accessToken
        print("accesstoken"+googleKey.accessToken);
      }).catchError((err) {
        // error while authentication
      });
    } catch (err) {
      print(err);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
      secureStorage.deleteSecureData('user_session');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: _isLoggedIn
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        user.photoURL,
                        height: 50.0,
                        width: 50.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('username') +
                            " : " +
                            user.name,
                        style: Theme.of(context).textTheme.display2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('email') +
                            " : " +
                            user.email,
                        style: Theme.of(context).textTheme.display2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('ID') +
                            " : " +
                            user.id,
                        style: Theme.of(context).textTheme.display2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      OutlineButton(
                        child: Text("Logout"),
                        onPressed: () {
                          var sessionId =
                              secureStorage.readSecureData('user_session');
                          print("session value from secure storage" +
                              sessionId.toString());
                          _logout();
                        },
                      )
                    ],
                  )
                : Center(
                    child: OutlineButton(
                      child: Text("Login with Google"),
                      onPressed: () {
                        _login();
                      },
                    ),
                  )),
      ),
    );
  }

  Future<bool> getUserData() async {
    var user = await SecureStorage().readSecureData('user_session');
    if (user != null)
      return true;
    else {
      return false;
    }
  }
  Future<String> refreshToken() async {
    print("Token Refresh");
    final GoogleSignInAccount googleSignInAccount =
    await _googleSignIn.signInSilently();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

   /* final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult = await auth.signInWithCredential(credential);*/

    return googleSignInAuthentication.accessToken; // New refreshed token
  }
}
