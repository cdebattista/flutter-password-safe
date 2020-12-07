import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:password/screens/developement_screen.dart';
import 'package:password/helpers/variables.dart';
import 'package:password/screens/password_screen.dart';
import 'package:password/screens/settings_screen.dart';

class NavDrawer extends StatefulWidget {
  final String currentRoute;

  const NavDrawer(this.currentRoute);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  Timer _timer;
  int _authTimeoutleft;

  @override
  void initState() {
    super.initState();
    //Timer to show on menu
    setState(() {
      _authTimeoutleft = authTimeoutleft;
    });
    Duration _countdown = Duration(seconds:1);
    _timer = Timer.periodic(_countdown, (Timer t){
      setState(() {
        _authTimeoutleft = authTimeoutleft;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> menu = [
      Container(
        height: 80.0,
        child: DrawerHeader(
          padding: EdgeInsets.all(0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    alignment: Alignment.center,
                    child: Image(
                      height: 35,
                      width: 35,
                      image: AssetImage("assets/images/launcher_icon/password.png"),
                  )
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                    alignment: Alignment.centerLeft,
                    child:Text(AppLocalizations.of(context).appName.toUpperCase(),
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.bold
                        )
                    )
                )
              ),
            ],
          )
        ),
      ),
      ListTile(
        title: Text(AppLocalizations.of(context).screensPasswordListTitle),
        tileColor: widget.currentRoute == "/" ? Theme.of(context).buttonColor : Theme.of(context).scaffoldBackgroundColor,
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PasswordScreen(),
            ),
          );
        },
      ),
      ListTile(
        title: Text(AppLocalizations.of(context).screensSettingsTitle),
        tileColor: widget.currentRoute == "settings" ? Theme.of(context).buttonColor : Theme.of(context).scaffoldBackgroundColor,
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SettingsScreen(),
            ),
          );
        },
      ),
      ListTile(
        title: Text("$_authTimeoutleft" + AppLocalizations.of(context).navDrawerSecondsLeft)
      ),
    ];

    if (env == "local") {
      menu.add(ListTile(
        tileColor: widget.currentRoute == "development" ? Theme.of(context).buttonColor : Theme.of(context).scaffoldBackgroundColor,
        title: Text(AppLocalizations.of(context).screensDevelopmentTitle),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DevelopementScreen(),
            ),
          );
        },
      ));
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: menu,
      ),
    );
  }
}
