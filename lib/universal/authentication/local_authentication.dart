import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';


class AuthenticationService {
  final LocalAuthentication auth = LocalAuthentication();
  final Function(bool) isAuthenticated;

  AuthenticationService({required this.isAuthenticated})
  {

    checkSupport();
  }



  Future<void> checkSupport() async {

    auth.isDeviceSupported().then(
          (bool isSupported) {

            isSupported? authenticate(): isAuthenticated(false);
          },
    );
    final List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();


  }
  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Authenticate yourself with PIN , patteren, password or fingerprint ',
        options: const AuthenticationOptions(
          sensitiveTransaction: true,
        ),
      );

    } on PlatformException catch (e) {

      isAuthenticated(false);
      return;
    }

    isAuthenticated(authenticated);

  }
}


