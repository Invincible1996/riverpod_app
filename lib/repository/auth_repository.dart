import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/auth_service.dart';

const String authToken = 'authToken';

const String isAuthenticated = 'isAuthenticated';

final sharedPrefProvider = Provider((_) async {
  return await SharedPreferences.getInstance();
});

/// 记录是否登录
final setIsAuthedProvider =
    StateProvider.family<void, bool>((ref, isAuthed) async {
  final sharedPref = await ref.watch(sharedPrefProvider);
  sharedPref.setBool(
    isAuthenticated,
    isAuthed,
  );
});

/// 获取登录状态
final getIsAuthedProvider = FutureProvider<bool>((ref) async {
  final sharedPref = await ref.watch(sharedPrefProvider);
  print('=========${sharedPref.getBool(isAuthenticated)}');
  return sharedPref.getBool(isAuthenticated) ?? false;
});

/// 清除登录状态
final clearIsAuthedProvider = FutureProvider<bool>((ref) async {
  debugPrint('clearIsAuthedProvider');
  final sharedPref = await ref.watch(sharedPrefProvider);
  return await sharedPref.clear();
});

class AuthRepository {
  final AuthService _authService;
  AuthRepository(this._authService);

  Future<String> login(String email, String password) async {
    return _authService.login(email, password);
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(authServiceProvider));
});
