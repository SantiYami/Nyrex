// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// Service responsible for all encryption/decryption operations in the Vault.
/// Follows "Encrypt by Default" principle using SOTA algorithms:
/// - Key Stretching: Argon2id (via cryptography package)
/// - Encryption: AES-256-GCM
class VaultCryptoService {
  VaultCryptoService._();

  static final _cipher = AesGcm.with256bits();

  /// Parameters for Argon2id stretching.
  static const int _argon2Iterations = 2;
  static const int _argon2Memory = 19456; // 19MiB
  static const int _argon2Parallelism = 1;

  /// Derives a 256-bit [SecretKey] from a raw password and a salt.
  static Future<SecretKey> deriveKey(String password, List<int> salt) async {
    final argon2id = Argon2id(
      parallelism: _argon2Parallelism,
      memory: _argon2Memory,
      iterations: _argon2Iterations,
      hashLength: 32,
    );

    // Key stretching is computationally intensive, but cryptography
    // package handles it efficiently.
    final secretKey = await argon2id.deriveKeyFromPassword(
      password: password,
      nonce: salt,
    );

    return secretKey;
  }

  /// Encrypts plaintext using AES-256-GCM.
  static Future<Uint8List> encrypt(
    String plainText,
    SecretKey secretKey,
  ) async {
    final clearText = utf8.encode(plainText);
    final secretBox = await _cipher.encrypt(clearText, secretKey: secretKey);

    final builder = BytesBuilder();
    builder.add(secretBox.nonce);
    builder.add(secretBox.mac.bytes);
    builder.add(secretBox.cipherText);

    return builder.toBytes();
  }

  /// Encrypts raw bytes using AES-256-GCM.
  static Future<Uint8List> encryptBytes(
    Uint8List data,
    SecretKey secretKey,
  ) async {
    final secretBox = await _cipher.encrypt(data, secretKey: secretKey);
    final builder = BytesBuilder();
    builder.add(secretBox.nonce);
    builder.add(secretBox.mac.bytes);
    builder.add(secretBox.cipherText);
    return builder.toBytes();
  }

  /// Decrypts raw bytes created by [encryptBytes].
  static Future<Uint8List> decryptBytes(
    Uint8List encryptedData,
    SecretKey secretKey,
  ) async {
    final nonce = encryptedData.sublist(0, 12);
    final mac = encryptedData.sublist(12, 28);
    final cipherText = encryptedData.sublist(28);
    final secretBox = SecretBox(cipherText, nonce: nonce, mac: Mac(mac));
    final clearBytes = await _cipher.decrypt(secretBox, secretKey: secretKey);
    return Uint8List.fromList(clearBytes);
  }

  /// Decrypts a blob created by [encrypt].
  static Future<String> decrypt(
    Uint8List encryptedData,
    SecretKey secretKey,
  ) async {
    final nonce = encryptedData.sublist(0, 12);
    final mac = encryptedData.sublist(12, 28);
    final cipherText = encryptedData.sublist(28);

    final secretBox = SecretBox(cipherText, nonce: nonce, mac: Mac(mac));
    final clearText = await _cipher.decrypt(secretBox, secretKey: secretKey);
    return utf8.decode(clearText);
  }
}
