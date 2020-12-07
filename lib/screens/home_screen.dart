import 'package:flutter/material.dart';
import 'package:password/helpers/auth.dart';
import 'package:password/helpers/passphrase_helper.dart';
import 'package:password/helpers/variables.dart';
import 'package:password/screens/auth_passphrase_screen.dart';
import 'package:password/screens/password_screen.dart';
import 'package:password/screens/set_passphrase_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    // Use to store the passphrase.
    // It will encrypt the passphrase with the encrypt key.
    storeEncryptKey().then((value) {
      // Global variable.
      encryptedKey = value;
      // We want to store the passphrase that user will enter.
      getPassPhrase('passphrase').then((value) {
        if (value != null) {
          // Global variable.
          encryptedPassPhrase = value;
          //Auth user by passphrase check
          session.get('user_passphrase').then((value) {
            if (value != null) {
              // User already set the passphrase
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => PasswordScreen(),
                ),
              );
            } else {
              // User have to auth
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => AuthPassPhraseScreen(),
                ),
              );
            }
          });
        } else {
          // User must enter passphrase
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SetPassPhraseScreen(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
