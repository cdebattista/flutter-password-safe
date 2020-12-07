import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password/helpers/cryptojs_aes_encryption_helper.dart';
import 'package:password/helpers/variables.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:password/screens/edit_password_screen.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filtre
    List where = passwordsList.where((password) {
      bool match = false;
      password.toMap().forEach((key, value) {
        if (value.toString().contains(query)) {
          match = true;
        }
      });
      if (match) {
        return true;
      }
      return false;
    }).toList();

    return ListView.builder(
        itemBuilder: (context, index) {
          String subtitle = "";
          if (where[index].service.isNotEmpty) {
            subtitle = where[index].service;
          }
          if (where[index].website.isNotEmpty) {
            if (subtitle.isNotEmpty) {
              subtitle += ": " + where[index].website;
            } else {
              subtitle = where[index].website;
            }
          }
          return Container(
            color: where[index].colorOrWhite(),
            child: ListTile(
              title: Text(
                where[index].name,
                style: TextStyle(color: where[index].foregroundWhiteOrBlack()),
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle,
                      style: TextStyle(
                          color: where[index].foregroundWhiteOrBlack()),
                    )
                  : null,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditPasswordScreen(where[index]),
                  ),
                );
              },
              onLongPress: () {
                Clipboard.setData(new ClipboardData(
                    text: decryptAESCryptoJS(
                        where[index].password, encryptedPassPhrase)));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    AppLocalizations.of(context).listPasswordPasswordCopied,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                  ),
                  backgroundColor: Theme.of(context).bottomAppBarColor,
                ));
              },
            ),
          );
        },
        itemCount: where.length);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          String subtitle = "";
          if (passwordsList[index].service.isNotEmpty) {
            subtitle = passwordsList[index].service;
          }
          if (passwordsList[index].website.isNotEmpty) {
            if (subtitle.isNotEmpty) {
              subtitle += ": " + passwordsList[index].website;
            } else {
              subtitle = passwordsList[index].website;
            }
          }
          return Container(
            color: passwordsList[index].colorOrWhite(),
            child: ListTile(
              title: Text(
                passwordsList[index].name,
                style: TextStyle(
                    color: passwordsList[index].foregroundWhiteOrBlack()),
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle,
                      style: TextStyle(
                          color: passwordsList[index].foregroundWhiteOrBlack()),
                    )
                  : null,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        EditPasswordScreen(passwordsList[index]),
                  ),
                );
              },
              onLongPress: () {
                Clipboard.setData(new ClipboardData(
                    text: decryptAESCryptoJS(
                        passwordsList[index].password, encryptedPassPhrase)));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    AppLocalizations.of(context).listPasswordPasswordCopied,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                  ),
                  backgroundColor: Theme.of(context).bottomAppBarColor,
                ));
              },
            ),
          );
        },
        itemCount: passwordsList.length);
  }
}
