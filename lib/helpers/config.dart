import 'package:password/helpers/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cryptojs_aes_encryption_helper.dart';


Future<String> setConfig(String config, String value) async {
  final prefs = await SharedPreferences.getInstance();
  final encryptedConfig = encryptAESCryptoJS(value, encryptedKey);
  prefs.setString(config, encryptedConfig);
  return value;
}

Future<String> getConfig(String config) async {
  final prefs = await SharedPreferences.getInstance();
  final decryptedConfig = decryptAESCryptoJS(prefs.getString(config), encryptedKey);
  return decryptedConfig;
}



