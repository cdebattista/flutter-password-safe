import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password/databases/seeds/passwordsSeeder.dart';
import 'package:password/helpers/variables.dart';
import 'package:password/models/passwords.dart';
import 'package:password/screens/auth_passphrase_screen.dart';
import 'package:password/widgets/nav/nav_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DevelopementScreen extends StatefulWidget {
  DevelopementScreen({Key key}) : super(key: key);

  @override
  _DevelopementScreenState createState() => _DevelopementScreenState();
}

class _DevelopementScreenState extends State<DevelopementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).screensDevelopmentTitle),
        ),
        drawer: NavDrawer('development'),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 3,
          // Generate 100 widgets that display their index in the List.
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: RaisedButton(
                textColor: Theme.of(context).primaryColor,
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Text("Seed database"),
                onPressed: () {
                  seedPasswordTable(database);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: RaisedButton(
                textColor: Theme.of(context).primaryColor,
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Text("Truncate database"),
                onPressed: () {
                  Password().truncate();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: RaisedButton(
                textColor: Theme.of(context).primaryColor,
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Text("UnAuthentification"),
                onPressed: () {
                  setState(() {
                    isAuth = false;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => AuthPassPhraseScreen(),
                      ),
                    );
                  });
                },
              ),
            )
          ],
        ));
  }
}
