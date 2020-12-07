import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:password/helpers/cryptojs_aes_encryption_helper.dart';
import 'package:password/helpers/variables.dart';
import 'package:password/models/passwords.dart';
import 'package:password/screens/edit_password_screen.dart';
import 'package:password/screens/password_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class PasswordList extends StatelessWidget {
  static const int PAGE_SIZE = 20;
  String category;

  PasswordList(this.category);

  Future<List<Password>> getPasswordsList(pageIndex) {
    return Stream.fromIterable(passwordsList)
        .where((password) {
          if (category != "ALL") {
            return password.category == category;
          }
          return true;
        })
        .skip(pageIndex * PAGE_SIZE)
        .take(PAGE_SIZE)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final _pageLoadController = PagewiseLoadController(
      pageSize: PAGE_SIZE,
      pageFuture: (pageIndex) => getPasswordsList(pageIndex),
    );

    return PagewiseListView(
      itemBuilder: (context, Password password, _) {
        List<Widget> widgets = [];
        String subtitle = "";
        if (password.service.isNotEmpty) {
          subtitle = password.service;
        }
        if (password.website.isNotEmpty) {
          widgets.add(IconSlideAction(
              caption: AppLocalizations.of(context).listPasswordLink,
              color: Theme.of(context).scaffoldBackgroundColor,
              iconWidget: Icon(
                Icons.link,
              ),
              onTap: () async {
                if (await canLaunch(password.website)) {
                  await launch(password.website);
                }
              }));
          if (subtitle.isNotEmpty) {
            subtitle += ": " + password.website;
          } else {
            subtitle = password.website;
          }
        }

        widgets.add(IconSlideAction(
          caption: AppLocalizations.of(context).listPasswordEdit,
          color: Theme.of(context).buttonColor,
          iconWidget: Icon(
            Icons.edit,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditPasswordScreen(password),
              ),
            );
          },
        ));
        widgets.add(
          IconSlideAction(
            caption: AppLocalizations.of(context).listPasswordDelete,
            color: Theme.of(context).errorColor,
            iconWidget: Icon(
              Icons.delete,
            ),
            closeOnTap: false,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Theme.of(context).dialogBackgroundColor,
                    title: Text(
                        AppLocalizations.of(context)
                            .listPasswordDeleteAlertTitle,
                        textAlign: TextAlign.center),
                    actions: [
                      FlatButton(
                        child: Text(
                          AppLocalizations.of(context).yes.toUpperCase(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        onPressed: () {
                          password.delete().then((value) {
                            passwordsList
                                .removeWhere((item) => item.id == password.id);
                            // Refresh if category doesn't exists anymore
                            int count = passwordsList
                                .where(
                                    (password) => password.category == category)
                                .length;
                            if (count == 0) {
                              activeTabIndex = 0;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PasswordScreen()));
                            } else {
                              // Otherwise refresh list

                              _pageLoadController.reset();
                              Navigator.of(context).pop();
                            }
                          });
                        },
                      ),
                      FlatButton(
                        child: Text(
                          AppLocalizations.of(context).no.toUpperCase(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
        );

        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            color: password.colorOrWhite(),
            child: ListTile(
              title: Text(
                password.name,
                style: TextStyle(color: password.foregroundWhiteOrBlack()),
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle,
                      style:
                          TextStyle(color: password.foregroundWhiteOrBlack()),
                    )
                  : null,
              onLongPress: () {
                Clipboard.setData(new ClipboardData(
                    text: decryptAESCryptoJS(
                        password.password, encryptedPassPhrase)));
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
          ),
          secondaryActions: widgets,
        );
      },
      pageLoadController: _pageLoadController,
    );
  }
}
