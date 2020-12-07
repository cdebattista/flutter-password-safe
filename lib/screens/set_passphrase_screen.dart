import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:password/helpers/auth.dart';
import 'package:password/helpers/config.dart';
import 'package:password/helpers/passphrase_helper.dart';
import 'package:password/helpers/variables.dart';
import 'package:password/screens/password_screen.dart';

class SetPassPhraseScreen extends StatefulWidget {
  SetPassPhraseScreen({Key key}) : super(key: key);

  @override
  _SetPassPhraseScreenState createState() => _SetPassPhraseScreenState();
}

class _SetPassPhraseScreenState extends State<SetPassPhraseScreen> {
// Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<AddPasswordFormState>.
  final _formKey = GlobalKey<FormState>();
  String passPhrase = "";
  final passPhraseFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).screensPassPhraseSetTitle),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(AppLocalizations.of(context)
                          .formsPasswordSetPassWarning),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  TextFormField(
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                      hintText: AppLocalizations.of(context)
                          .formsPasswordSetPassPhraseHint,
                      hintStyle: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                      labelText: AppLocalizations.of(context)
                          .formsPasswordSetPassPhraseLabel,
                    ),
                    validator: (name) {
                      if (name.isEmpty) {
                        return AppLocalizations.of(context)
                            .formsPasswordSetPassPhraseEmpty;
                      }
                      if (name.length < 8) {
                        return AppLocalizations.of(context)
                            .formsPasswordSetPassPhraseLenght;
                      }
                      return null;
                    },
                    initialValue: passPhrase,
                    autofocus: false,
                    focusNode: passPhraseFocusNode,
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(passPhraseFocusNode);
                    },
                    onSaved: (passPhrase) {
                      this.passPhrase = passPhrase;
                    },
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: screenSize.width,
                    child: new RaisedButton(
                      child: new Text(AppLocalizations.of(context).save),
                      onPressed: () {
                        final FormState form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          storePassPhrase(passPhrase).then((value) {
                            if (value != null) {
                              encryptedPassPhrase = value;
                              isAuth = true;
                              // Init config after passphrase is set
                              setConfig('auth_timeout', authTimeout).then((value){
                                authTimerRedirect();
                              });
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PasswordScreen(),
                                ),
                              );
                            }
                          });
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
