import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isLoggedIn;
  final bool isLoading;

  AuthState({this.isLoggedIn = false, this.isLoading = false});

  AuthState copyWith({bool? isLoggedIn, bool? isLoading}) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 1)); // Mock delay
    state = state.copyWith(isLoggedIn: true, isLoading: false);
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 1)); // Mock delay
    state = state.copyWith(isLoggedIn: false, isLoading: false);
  }

  Future<void> signup(String email, String password) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 1)); // Mock delay
    // After signup, we might want to log them in or just finish loading
    // For this flow, we'll just finish loading and let the UI navigate
    state = state.copyWith(isLoading: false);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
