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
enum AuthState { isAuth, isNotAuth, isReturning }

class AuthStateNotifier extends ChangeNotifier {
  final AuthRepository _authRepository;
  // final _profileRepo = ProfileRepository();

  AuthStateNotifier(this._authRepository);

  Enum? _authState = isReturning();

  // ignore: unnecessary_this
  get authState => this._authState;

  final tokens = Hive.box<Token>('token');
  final user = Hive.box<User>('user');
  // final profile = Hive.box<Profile>('profile');

  void isAuth() {
    _authState = AuthState.isAuth;
    notifyListeners();
  }

  void isNotAuth() {
    _authState = AuthState.isNotAuth;
    notifyListeners();
  }

  // void noProfile() {
  //   _authState = AuthState.noProfile;
  //   notifyListeners();
  // }

  static AuthState isReturning() {
    final tokens = Hive.box<Token>('token');
    // final profile = Hive.box<Profile>('profile');
    AuthState _authState;

    if (tokens.isNotEmpty) {
      // if (profile.isEmpty) {
      //   _authState = AuthState.noProfile;
      // } else {
      /// If The Token has not expired or if the token is less than 30 Days Old Auto Login
      !JWTChecker.hasExpired(tokens.values.first.jwt) ||
              JWTChecker.isTooOld(tokens.values.first.jwt) < 30
          ? _authState = AuthState.isAuth
          : _authState = AuthState.isNotAuth;
      // }
    } else {
      _authState = AuthState.isNotAuth;
    }
    return _authState;
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
      user.put(0, response.login.user);
      //Store Token Data
      tokens.put(0, token);

      //Does User Have Profile
      // Profile userProfile = await _profileRepo.getProfile();
      // profile.put(0, userProfile);

      //Change Auth State
      isAuth();
      // } on NoProfileException {
      //   //Change State To No Profile
      //   noProfile();
      // }
    } catch (e) {
      print(e);
      isNotAuth();
      tokens.clear(); //Todo Network Exceptions
      user.clear();
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
        tokens.put(0, token);
        user.put(0, response.register.user);

        isAuth();
        return response;
      }
    } catch (e) {
      print(e);
      isNotAuth();
      // userTeam.clear();
      tokens.clear(); //Todo Network Exceptions
      user.clear();
      // profile.clear();
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await user.clear();
      await tokens.clear();
      // await profile.clear();
    } catch (e) {
      isNotAuth();
    }
    isNotAuth();
  }
}
