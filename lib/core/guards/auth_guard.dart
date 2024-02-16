import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard {
  static Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  static Future<void> canActivate(
    BuildContext context,
    GoRouterState state,
  ) async {
    final isAuth = await isAuthenticated();
    if (!isAuth) {
      GoRouter.of(context).go('/login');
    }
  }
}
