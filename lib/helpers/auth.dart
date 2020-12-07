import 'dart:async';

import 'package:flutter/material.dart';
import 'package:password/helpers/variables.dart';
import 'package:password/screens/auth_passphrase_screen.dart';

bool userIsAuth(context) {
  if (!isAuth) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => AuthPassPhraseScreen(),
      ),
    );
  }
  return true;
}

void authTimerRedirect(){
  // Timer each 5 minutes for exemple
  if(authTimeoutTimer != null){
    authTimeoutTimer.cancel();
  }
  int _authTimeout = int.parse(authTimeout);
  Duration time = Duration(minutes:_authTimeout);
  authTimeoutTimer = Timer.periodic(time, (Timer t){
    // Kill timer on auth page
    if(authTimeoutTimer != null){
      authTimeoutTimer.cancel();
    }
    if(authTimeoutLeftTimer != null){
      authTimeoutLeftTimer.cancel();
    }
    isAuth = false;
    navigatorKey.currentState.pushNamed('auth');
  });

  // Timer decrement
  if(authTimeoutLeftTimer != null){
    authTimeoutLeftTimer.cancel();
  }
  authTimeoutleft = _authTimeout * 60;
  Duration countdown = Duration(seconds:1);
  authTimeoutLeftTimer = Timer.periodic(countdown, (Timer t){
    if(authTimeoutleft == 0){
      authTimeoutleft = _authTimeout * 60;
    }
    authTimeoutleft--;
  });
}
