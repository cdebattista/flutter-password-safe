import 'dart:math';

import 'package:basic_utils/basic_utils.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:password/helpers/cryptojs_aes_encryption_helper.dart';
import 'package:password/helpers/variables.dart';
import 'package:password/models/passwords.dart';

List categories = [
  "Linux",
  "Windows",
  "Mac",
  "FTP",
  "SFTP",
  "SSH",
  "Gmail",
  "Hotmail",
  "Credit Card",
  "Crypto",
  "Wifi"
];

seedPasswordTable(db) {
  Password().truncate();
  for (var i = 0; i < 200; i++) {
    Password(
            name: faker.company.name(),
            category: StringUtils.capitalize((categories..shuffle()).first,
                allWords: true),
            color: Colors
                .primaries[Random().nextInt(Colors.primaries.length)].value
                .toRadixString(16),
            website: faker.internet.httpUrl(),
            service: faker.internet.domainName(),
            password: encryptAESCryptoJS(
                faker.internet.password(), encryptedPassPhrase))
        .insert();
  }
}
