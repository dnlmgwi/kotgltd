import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kotgltd/features/auth/model/login_response.dart';
// import 'package:kotgltd/features/auth/model/profile.dart';
import 'package:kotgltd/features/auth/model/register_response.dart';
import 'package:kotgltd/features/auth/model/token.dart';
import 'package:kotgltd/features/auth/model/user.dart';
import 'package:kotgltd/features/auth/services/auth_repository.dart';
import 'package:kotgltd/features/auth/services/jwt_checker.dart';
import 'package:kotgltd/packages/core.dart';
import 'package:kotgltd/packages/dependencies.dart';

// import 'package:supabase/supabase.dart';
enum AuthState { isLoggedIn, isNotLoggedIn }

class AuthStateNotifier extends ChangeNotifier {
  final AuthRepository _authRepository;
  // final _profileRepo = ProfileRepository();

  AuthStateNotifier(this._authRepository);

  static Enum authState = isReturning();

  // ignore: unnecessary_this
  Enum get _authState => authState;

  final _tokens = Hive.box<Token>('token');
  final _user = Hive.box<User>('user');

  void isAuth() {
    authState = AuthState.isLoggedIn;
    notifyListeners();
  }

  void isNotAuth() {
    authState = AuthState.isNotLoggedIn;
    notifyListeners();
  }

  static Enum isReturning() {
    final tokens = Hive.box<Token>('token');
    // final profile = Hive.box<Profile>('profile');

    if (tokens.isNotEmpty) {
      /// If The Token has not expired or if the token is less than 30 Days Old Auto Login
      !JWTChecker.hasExpired(tokens.values.first.jwt) ||
              JWTChecker.isTooOld(tokens.values.first.jwt) < 30
          ? authState = AuthState.isLoggedIn
          : authState = AuthState.isNotLoggedIn;
      // }
    } else {
      authState = AuthState.isNotLoggedIn;
    }
    return authState;
  }

  Stream<Enum?> authStateChanges() => Stream<Enum?>.value(_authState);

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    LoginResponse? response;

    try {
      response = await _authRepository.signIn(
        email: email,
        password: password,
      );
      var token = Token(jwt: response!.login.jwt);
      //Store User Data
      _user.put(0, response.login.user);
      //Store Token Data
      _tokens.put(0, token);
      //Change Auth State
      isAuth();
    } catch (e) {
      print(e);
      isNotAuth();
      _tokens.clear(); //Todo Network Exceptions
      _user.clear();
      // profile.clear();
      rethrow;
    }
  }

  Future<RegisterResponse?> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    RegisterResponse? response;
    try {
      //TODO Check Username availabilty
      //TODO Suggest Username based off Entry

      response = await _authRepository.signUp(
        email: email,
        password: password,
        username: username,
      );

      if (response!.toJson().isNotEmpty) {
        //success
        var token = Token(jwt: response.register.jwt);
        _tokens.put(0, token);
        _user.put(0, response.register.user);

        isAuth();
      }
      return response;
    } catch (e) {
      print(e);
      isNotAuth();
      // userTeam.clear();
      _tokens.clear(); //Todo Network Exceptions
      _user.clear();
      // profile.clear();
      rethrow;
    }
  }

  Future updateProfile({
    required String firstname,
    required String lastname,
    required String dateOfBirth,
    required PhoneNumber phoneNumber,
  }) async {
    RegisterResponse? response;
    try {
      //TODO Check Username availabilty
      //TODO Suggest Username based off Entry

      // response = await _authRepository.signUp(
      //   email: email,
      //   password: password,
      //   username: username,
      // );

      if (response!.toJson().isNotEmpty) {
        //success
        var token = Token(jwt: response.register.jwt);
        _tokens.put(0, token);
        _user.put(0, response.register.user);

        isAuth();
      }
      return response;
    } catch (e) {
      print(e);
      isNotAuth();
      // userTeam.clear();
      _tokens.clear(); //Todo Network Exceptions
      _user.clear();
      // profile.clear();
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _user.clear();
      await _tokens.clear();
      // await profile.clear();

      isNotAuth();
    } catch (e) {
      isNotAuth();
    }
  }
}
