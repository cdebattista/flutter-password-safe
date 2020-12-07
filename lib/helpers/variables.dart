import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:password/models/passwords.dart';
import 'package:sqflite/sqflite.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
bool debug = false;
String env = "production";
FlutterSession session;
Future<Database> database;
String encryptedKey;
String encryptedPassPhrase;
bool isAuth = false;
int activeTabIndex = 0;
List<String> categoriesList = [];
List<Password> passwordsList = [];
String authTimeout = "5";
int authTimeoutleft = 5;
Timer authTimeoutTimer;
Timer authTimeoutLeftTimer;
