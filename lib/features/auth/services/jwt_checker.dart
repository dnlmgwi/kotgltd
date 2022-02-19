import 'package:jwt_decoder/jwt_decoder.dart';

class JWTChecker {
  static bool hasExpired(token) {
    bool hasExpired = JwtDecoder.isExpired(token);
    return hasExpired;
  }

  static int isTooOld(token) {
    Duration tokenTime = JwtDecoder.getTokenTime(token);
    return tokenTime.inDays;
  }
}
