import 'package:kotgltd/features/auth/model/login_response.dart';
import 'package:kotgltd/features/auth/model/register_response.dart';

abstract class IAuthRepository {
  ///Sign In
  Future<LoginResponse?> signIn({
    required String email,
    required String password,
  });

  ///Sign Up
  Future<RegisterResponse?> signUp({
    required String username,
    required String email,
    required String password,
  });

  ///Forgot Password
  Future<void> forgotPassword({
    required String email,
  });
}
