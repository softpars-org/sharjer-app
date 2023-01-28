import 'dart:convert';

import 'package:cryptography/cryptography.dart';

class Encryption {
  final String _secretKeyString = "mojtama-amoli-residentialcomplex";
  final String _iv = "mojtama-amoliaaa";
  Future<String> encrypt(String plainText) async {
    List<int> plainTextCodes = utf8.encode(plainText);
    List<int> secretKeyCodes = utf8.encode(_secretKeyString);
    final secretKey = SecretKey(secretKeyCodes);
    final algorithm = AesCbc.with256bits(macAlgorithm: MacAlgorithm.empty);
    final List<int> iv = utf8.encode(_iv);
    final secretBox = await algorithm.encrypt(plainTextCodes,
        secretKey: secretKey, nonce: iv);
    return base64Encode(secretBox.cipherText);
  }

  decrypt(String cipherText) async {
    List<int> cipherTextCodes = base64Decode(cipherText);
    List<int> secretKeyCodes = utf8.encode(_secretKeyString);
    SecretKey secretKey = SecretKey(
      secretKeyCodes,
    );
    List<int> iv = utf8.encode(_iv);
    final algorithm = AesCbc.with256bits(macAlgorithm: MacAlgorithm.empty);
    final SecretBox secretBox = SecretBox(
      cipherTextCodes,
      nonce: iv,
      mac: Mac.empty,
    );
    final plainText = await algorithm.decrypt(secretBox, secretKey: secretKey);
    return utf8.decode(plainText);
  }
}
