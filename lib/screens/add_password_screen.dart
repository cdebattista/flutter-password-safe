import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:password/helpers/auth.dart';
import 'package:password/helpers/cryptojs_aes_encryption_helper.dart';
import 'package:password/helpers/variables.dart';
import 'package:password/models/passwords.dart';
import 'package:password/screens/password_screen.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:http/http.dart' as http;

class AddPasswordScreen extends StatefulWidget {
  AddPasswordScreen({Key key}) : super(key: key);

  @override
  _AddPasswordScreenState createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final TextEditingController _typeAheadController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formResult = Password();
  final nameFocusNode = FocusNode();
  final categoryFocusNode = FocusNode();
  final websiteFocusNode = FocusNode();
  final serviceFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  bool _obscureText = true;
  Size screenSize;
  Color currentColor;

  @override
  void initState() {
    super.initState();
    userIsAuth(context);
    currentColor = Color(0xff212121);
  }

  @override
  void dispose() {
    _typeAheadController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).screensPasswordAddTitle),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PasswordScreen()),
              );
            },
          ),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                      hintText:
                          AppLocalizations.of(context).formsPasswordAddNameHint,
                      hintStyle: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                      labelText: AppLocalizations.of(context)
                          .formsPasswordAddNameLabel,
                    ),
                    validator: (name) {
                      if (name.isEmpty) {
                        return AppLocalizations.of(context)
                            .formsPasswordAddValidatorNameEmpty;
                      }
                      if (name.length < 3) {
                        return AppLocalizations.of(context)
                            .formsPasswordAddValidatorNameLenght;
                      }
                      return null;
                    },
                    initialValue: _formResult.name,
                    autofocus: false,
                    focusNode: nameFocusNode,
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(nameFocusNode);
                    },
                    onSaved: (name) {
                      _formResult.name = name;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TypeAheadFormField(
                    noItemsFoundBuilder: (context){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          AppLocalizations.of(context).formsPasswordAddCategoryEmpty,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).disabledColor, fontSize: 18.0),
                        ),
                      );
                    },
                    textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        focusNode: categoryFocusNode,
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          FocusScope.of(context)
                              .requestFocus(categoryFocusNode);
                        },
                        controller: _typeAheadController,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Theme.of(context).errorColor,
                          ),
                          hintText: AppLocalizations.of(context)
                              .formsPasswordAddCategoryHint,
                          hintStyle: TextStyle(
                            color: Theme.of(context).hintColor,
                          ),
                          labelText: AppLocalizations.of(context)
                              .formsPasswordAddCategoryLabel,
                        )),
                    suggestionsCallback: (pattern) async {
                      return await Password().categories();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion['category']),
                      );
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (suggestion) {
                      _typeAheadController.text = suggestion['category'];
                    },
                    onSaved: (category) {
                      _formResult.category = category;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                      hintText: AppLocalizations.of(context)
                          .formsPasswordAddWebsiteHint,
                      hintStyle: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                      labelText: AppLocalizations.of(context)
                          .formsPasswordAddWebsiteLabel,
                    ),
                    validator: (webiste) {
                      if (webiste.length >= 1) {
                        return DomainUtils.isDomainName(webiste)
                            ? null
                            : AppLocalizations.of(context)
                                .formsPasswordAddWebsiteValidatorUrl;
                      }
                      return null;
                    },
                    initialValue: _formResult.website,
                    autofocus: false,
                    focusNode: websiteFocusNode,
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(websiteFocusNode);
                    },
                    onSaved: (website) {
                      _formResult.website = website;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                      hintText: AppLocalizations.of(context)
                          .formsPasswordAddServiceHint,
                      hintStyle: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                      labelText: AppLocalizations.of(context)
                          .formsPasswordAddServiceLabel,
                    ),
                    initialValue: _formResult.service,
                    autofocus: false,
                    focusNode: serviceFocusNode,
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(serviceFocusNode);
                    },
                    onSaved: (service) {
                      _formResult.service = service;
                    },
                  ),
                  SizedBox(height: 10.0),
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
                          .formsPasswordAddPasswordHint,
                      hintStyle: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                      labelText: AppLocalizations.of(context)
                          .formsPasswordAddPasswordLabel,
                    ),
                    validator: (password) {
                      if (password.isEmpty) {
                        return AppLocalizations.of(context)
                            .formsPasswordAddValidatorPasswordEmpty;
                      }
                      return null;
                    },
                    initialValue: _formResult.password,
                    autofocus: false,
                    obscureText: _obscureText,
                    focusNode: passwordFocusNode,
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                    onSaved: (password) {
                      _formResult.password = password;
                    },
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: screenSize.width,
                    child: RaisedButton(
                      elevation: 3.0,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              titlePadding: const EdgeInsets.all(0.0),
                              contentPadding: const EdgeInsets.all(0.0),
                              content: SingleChildScrollView(
                                child: MaterialPicker(
                                  pickerColor: currentColor,
                                  onColorChanged: changeColor,
                                  enableLabel: true,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(AppLocalizations.of(context)
                          .formsPasswordAddChangeColor),
                      color: currentColor,
                      textColor: useWhiteForeground(currentColor)
                          ? const Color(0xffffffff)
                          : const Color(0xff000000),
                    ),
                  ),
                  Container(
                    width: screenSize.width,
                    child: new RaisedButton(
                      child: new Text(AppLocalizations.of(context).save),
                      onPressed: () {
                        final FormState form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          final password = Password(
                                  name: _formResult.name,
                                  category: (_formResult.category != "") ? StringUtils.capitalize(_formResult.category, allWords: true) : null,
                                  color: currentColor.value.toRadixString(16),
                                  website: _formResult.website,
                                  service: _formResult.service,
                                  password: encryptAESCryptoJS(
                                      _formResult.password,
                                      encryptedPassPhrase))
                              .insert()
                              .then((password) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PasswordScreen()),
                            );
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
