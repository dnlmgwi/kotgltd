import 'package:kotgltd/features/auth/model/login_response.dart';
import 'package:kotgltd/features/auth/model/register_response.dart';

abstract class IAuthRepository {
  ///Sign In to API
  Future<LoginResponse?> signIn({
    required String email,
    required String password,
  });

  ///Sign Up to API
  Future<RegisterResponse?> signUp({
    required String username,
    required String email,
    required String password,
  });

  ///Forgot Password to API
  Future<void> forgotPassword({
    required String email,
  });
}
