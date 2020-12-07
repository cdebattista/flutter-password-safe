import 'package:shared_preferences/shared_preferences.dart';
import 'random_bytes_generator_helper.dart';
import 'cryptojs_aes_encryption_helper.dart';

Future<bool> isPassPhraseStored(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) != null ? true : false;
}

Future<bool> setPassPhrase(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.setString('key', value);
}

Future<String> getPassPhrase(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<String> storePassPhrase(passPhrase) async {
  final prefs = await SharedPreferences.getInstance();
  final encryptedKey = prefs.getString('encryptedKey');
  if (encryptedKey != null) {
    final encryptedPassphrase = encryptAESCryptoJS(passPhrase, encryptedKey);
    prefs.setString('passphrase', encryptedPassphrase);
    return encryptedPassphrase;
  }
}

Future<String> storeEncryptKey() async {
  final prefs = await SharedPreferences.getInstance();
  final encryptedKey = prefs.getString('encryptedKey');
  if (encryptedKey == null) {
    final random = rbgenerator.CreateCryptoRandomString();
    prefs.setString('encryptedKey', random);
    return random;
  }
  return encryptedKey;
}
