import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password/helpers/auth.dart';
import 'package:password/helpers/config.dart';
import 'package:password/helpers/variables.dart';
import 'package:password/widgets/nav/nav_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Size screenSize;
  final _formKey = GlobalKey<FormState>();
  final authTimeoutFocusNode = FocusNode();
  String _timeout;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).screensSettingsTitle),
        ),
        drawer: NavDrawer('settings'),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              TextFormField(
                decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Theme.of(context).errorColor,
                    ),
                  hintText: AppLocalizations.of(context).formsSettingsTimeoutHint,
                    hintStyle: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                  labelText: AppLocalizations.of(context).formsSettingsTimeoutLabel
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                initialValue: authTimeout,
                autofocus: false,
                focusNode: authTimeoutFocusNode,
                textInputAction: TextInputAction.next,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(authTimeoutFocusNode);
                },
                validator: (timeout) {
                  if (timeout.isEmpty) {
                    return AppLocalizations.of(context).formsSettingsTimeoutEmpty;
                  }
                  if(timeout != null) {
                    if (int.parse(timeout) < 1) {
                      return AppLocalizations.of(context).formsSettingsTimeoutNotLess;
                    }
                  }
                  return null;
                },
                onSaved: (timeout) {
                  _timeout = timeout;
                }
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
                      setConfig('auth_timeout', _timeout).then((value){
                        authTimeout = _timeout;
                        authTimerRedirect();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          AppLocalizations.of(context).settingsScreenFormSaveScaffoldMessenger,
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                        ),
                        backgroundColor: Theme.of(context).bottomAppBarColor,
                      ));
                    }
                  },
                  color: Theme.of(context).buttonColor,
                ),
                margin: new EdgeInsets.only(top: 20.0),
              )
            ],
          ),
        )
      ),
    );
  }
}
