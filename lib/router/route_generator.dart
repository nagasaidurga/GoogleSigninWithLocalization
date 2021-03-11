import 'package:flutter/material.dart';
import 'package:secure_signin_custom_theme/ui/google_auth.dart';
import 'package:secure_signin_custom_theme/ui/google_signin.dart';
import 'package:secure_signin_custom_theme/ui/home_screen.dart';
import 'package:secure_signin_custom_theme/ui/index.dart';
import 'package:secure_signin_custom_theme/utils/secure_storage.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings)  {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
            return MaterialPageRoute(builder: (_) => LoginScreen());
      break;
      case '/second':
      // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => HomeScreen(
              data: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case '/googleprocess':
           return MaterialPageRoute(
          builder: (_) => GoogleSigninProcess(),
        );
        case '/authprocess':
      // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => GoogleAuthProcess(),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
