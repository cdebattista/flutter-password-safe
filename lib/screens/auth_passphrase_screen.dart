import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:password/helpers/auth.dart';
import 'package:password/helpers/config.dart';
import 'package:password/helpers/cryptojs_aes_encryption_helper.dart';
import 'package:password/helpers/passphrase_helper.dart';
import 'package:password/helpers/variables.dart';
import 'package:password/screens/add_password_screen.dart';
import 'package:password/screens/password_screen.dart';

class AuthPassPhraseScreen extends StatefulWidget {
  AuthPassPhraseScreen({Key key}) : super(key: key);

  @override
  _AuthPassPhraseScreenState createState() => _AuthPassPhraseScreenState();
}

class _AuthPassPhraseScreenState extends State<AuthPassPhraseScreen> {
  final _formKey = GlobalKey<FormState>();
  final passPhraseFocusNode = FocusNode();
  String passPhrase = "";
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
                  AppLocalizations.of(context).screensPassPhraseAuthTitle)),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  SizedBox(height: 50.0),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).buttonColor,
                        ),
                        onPressed: _toggle,
                      ),
                      errorStyle: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                      hintText: AppLocalizations.of(context)
                          .formsPassPhraseSetAuthHint,
                      hintStyle: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                      labelText: AppLocalizations.of(context)
                          .formsPassPhraseSetAuthLabel,
                    ),
                    initialValue: passPhrase,
                    autofocus: false,
                    focusNode: passPhraseFocusNode,
                    textInputAction: TextInputAction.next,
                    obscureText: _obscureText,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(passPhraseFocusNode);
                    },
                    onSaved: (value) {
                      passPhrase = value;
                    },
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: screenSize.width,
                    child: new RaisedButton(
                      child: new Text(AppLocalizations.of(context).connect),
                      onPressed: () {
                        final FormState form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          //user passphrase match stored passphrase
                          if (decryptAESCryptoJS(encryptedPassPhrase, encryptedKey) == passPhrase) {
                            isAuth = true;
                            // Active timer redirect
                            getConfig('auth_timeout').then((value){
                              authTimeout = value;
                              authTimerRedirect();
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PasswordScreen(),
                              ),
                            );
                          }
                        }
                      },
                      color: Theme.of(context).buttonColor,
                    ),
                    margin: new EdgeInsets.only(top: 20.0),
                  )
                ],
              )),
        ));
  }
}
