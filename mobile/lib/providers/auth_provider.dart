import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? userId;
  final String? userName;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.userId,
    this.userName,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? userId,
    String? userName,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> login(String phone, String otp) async {
    state = state.copyWith(isLoading: true, error: null);

    // TODO: Replace with real API call
    await Future.delayed(const Duration(seconds: 2));

    if (otp == '123456') {
      state = state.copyWith(
        isAuthenticated: true,
        userId: 'user_123',
        userName: 'Citizen',
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: 'Invalid OTP',
      );
    }
  }

  void logout() {
    state = const AuthState();
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
