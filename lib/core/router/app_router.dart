
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_practice/features/auth/provider/auth_provider.dart';

import 'package:riverpod_practice/features/auth/presentation/pages/login_page.dart';
import 'package:riverpod_practice/features/auth/presentation/pages/profile_setup_page.dart';
import 'package:riverpod_practice/features/auth/presentation/pages/signup_page.dart';
import 'package:riverpod_practice/features/home/presentation/pages/home_page.dart';
import 'package:riverpod_practice/features/notification/presentation/pages/notification_page.dart';
import 'package:riverpod_practice/features/post/presentation/pages/post_add_page.dart';
import 'package:riverpod_practice/features/post/presentation/pages/post_detail_page.dart';
import 'package:riverpod_practice/features/settings/presentation/pages/settings_page.dart';
import 'package:riverpod_practice/features/splash/presentation/pages/splash_page.dart';
import 'package:riverpod_practice/features/user/presentation/pages/mypage.dart';
import 'package:riverpod_practice/features/user/presentation/pages/profile_edit_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState.isLoggedIn;
      final path = state.uri.toString();
      
      final isSplash = path == '/';
      final isLoggingIn = path == '/login';
      final isSigningUp = path == '/signup';
      final isProfileSetup = path == '/profile-setup';

      if (isLoggedIn) {
        // If logged in and trying to access auth pages or splash, redirect to home
        if (isLoggingIn || isSigningUp || isSplash || isProfileSetup) {
          return '/home';
        }
      } else {
        // If not logged in
        // Allow splash, login, signup, profile-setup
        if (isSplash || isLoggingIn || isSigningUp || isProfileSetup) {
          return null;
        }
        // Redirect everything else to login
        return '/login';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/post/add',
        builder: (context, state) => const PostAddPage(),
      ),
      GoRoute(
        path: '/post/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PostDetailPage(id: id);
        },
      ),
      GoRoute(
        path: '/notification',
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: '/mypage',
        builder: (context, state) => const MyPage(),
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) => const ProfileEditPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
});
