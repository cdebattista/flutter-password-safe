import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:password/helpers/auth.dart';
import 'package:password/helpers/variables.dart';
import 'package:password/models/passwords.dart';
import 'package:password/widgets/nav/nav_drawer.dart';
import 'package:password/widgets/search.dart';
import 'package:password/widgets/views/passwords/list.dart';

import 'add_password_screen.dart';

class PasswordScreen extends StatefulWidget {
  PasswordScreen({Key key}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen>
    with TickerProviderStateMixin {
  bool _tabLoaded = false;
  TabController _tabController;
  List<Map<String, dynamic>> _tabs = [];

  @override
  void initState() {
    super.initState();
    userIsAuth(context);
    _addTab();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addTab() {
    categoriesList = [];
    passwordsList = [];
    setState(() {
      _tabs.add({
        'category': 'ALL',
      });
      Password().all().then((value) {
        for (var i = 0; i < value.length; i++) {
          passwordsList.add(value[i]);
        }
      });
      Password().categories().then((value) {
        for (var i = 0; i < value.length; i++) {
          if (value[i]["category"].toString().isNotEmpty) {
            categoriesList.add(value[i]["category"]);
            _tabs.add({
              'category': value[i]["category"],
            });
          }
        }
        _tabController = TabController(
          vsync: this,
          length: _tabs.length,
          initialIndex: activeTabIndex,
        );
        _tabController.addListener(_setActiveTabIndex);

        _tabLoaded = true;
      });
    });
  }

  void _setActiveTabIndex() {
    activeTabIndex = _tabController.index;
  }

  Future<void> getFutureData() async {
    while (_tabLoaded == false) {
      await Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFutureData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return DefaultTabController(
              length: _tabs.length,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                      AppLocalizations.of(context).screensPasswordListTitle),
                  bottom: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: _tabs
                        .map((tab) => Tab(
                              text: tab["category"],
                            ))
                        .toList(),
                  ),
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch());
                        }),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddPasswordScreen(),
                          ),
                        );
                      },
                    )
                  ],
                ),
                drawer: NavDrawer('/'),
                body: Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.only(top: 10),
                    child: TabBarView(
                      key: Key(Random().nextDouble().toString()),
                      controller: _tabController,
                      children: _tabs
                          .map((tab) => PasswordList(tab["category"]))
                          .toList(),
                    )),
              ),
            );
          }
        });
  }
}
