import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to access the [SecureStorageService] instance.
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  return SecureStorageService(storage);
});

/// A service to read, write, and delete secure sensitive credentials (e.g. JWT tokens).
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  /// Save the API access token.
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  /// Read the saved API access token.
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Delete the saved API access token.
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accessTokenKey);
  }

  /// Save the API refresh token.
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  /// Read the saved API refresh token.
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Delete the saved API refresh token.
  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshTokenKey);
  }

  /// General write option for any custom sensitive information.
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// General read option for any custom sensitive information.
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// General delete option for a single sensitive key.
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Clear all stored secure keys.
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
